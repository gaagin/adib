import importlib.util
from pathlib import Path
import tempfile
import unittest

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('patcher', HERE / 'apply_keyboard_insets.py')
patcher = importlib.util.module_from_spec(spec)
spec.loader.exec_module(patcher)

class InsetsPatchTests(unittest.TestCase):
    def test_ime_is_included_before_padding_and_consumption(self):
        smali = (HERE / 'inset-method.smali').read_text()
        self.assertLess(smali.index('->ime()I'), smali.index('->setPadding(IIII)V'))
        self.assertLess(smali.index('->setPadding(IIII)V'), smali.index('->CONSUMED:'))
        self.assertIn('invoke-static {v3, v5}, Ljava/lang/Math;->max(II)I', smali)
        self.assertIn('{p1, v4, v2, v0, v5}', smali)

    def test_navigation_scrim_uses_navigation_height_not_keyboard_height(self):
        smali = (HERE / 'inset-method.smali').read_text()
        self.assertIn('iput v3, p1, Landroid/widget/FrameLayout$LayoutParams;->height:I', smali)
        self.assertIn('neg-int v0, v5', smali)

    def test_legacy_branch_keeps_adjust_resize(self):
        smali = (HERE / 'inset-method.smali').read_text()
        legacy = smali.split('\n    :cond_0\n', 1)[1].split('\n    :goto_0\n', 1)[0]
        self.assertNotIn('->ime()', legacy)
        self.assertIn('move v5, v3', legacy)

    def test_apply_is_idempotent_and_does_not_modify_other_methods(self):
        with tempfile.TemporaryDirectory() as temp:
            target = Path(temp) / 'smali/com/adib/maintenance/OnlineMainActivity.smali'
            target.parent.mkdir(parents=True)
            original = (HERE / 'inset-method.original.smali').read_text().rstrip('\n')
            target.write_text('before\n' + original + '\nafter\n')
            self.assertTrue(patcher.apply(temp))
            expected = 'before\n' + (HERE / 'inset-method.smali').read_text().rstrip('\n') + '\nafter\n'
            self.assertEqual(target.read_text(), expected)
            self.assertFalse(patcher.apply(temp))
            self.assertEqual(target.read_text(), expected)

    def test_unknown_version_is_rejected_without_writes(self):
        with tempfile.TemporaryDirectory() as temp:
            target = Path(temp) / 'smali/com/adib/maintenance/OnlineMainActivity.smali'
            target.parent.mkdir(parents=True)
            unknown = patcher.METHOD + ')V\n.locals 0\nreturn-void\n.end method'
            target.write_text(unknown)
            with self.assertRaises(ValueError):
                patcher.apply(temp)
            self.assertEqual(target.read_text(), unknown)

if __name__ == '__main__':
    unittest.main()
