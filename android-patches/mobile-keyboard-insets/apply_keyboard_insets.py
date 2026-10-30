#!/usr/bin/env python3
"""Patch only the inset callback in an apktool ADIB 1.1.x project."""
import hashlib
from pathlib import Path
import sys

METHOD = '.method private synthetic lambda$addInsetHandling$1('
ORIGINAL_SHA256 = '921618bbae53bd6e8c7b59321574ab6d4cba90e2d647c7ce49fdd4c511179331'


def apply(project):
    path = Path(project) / 'smali/com/adib/maintenance/OnlineMainActivity.smali'
    source = path.read_text(encoding='utf-8')
    start = source.index(METHOD)
    end = source.index('.end method', start) + len('.end method')
    current = source[start:end]
    replacement = Path(__file__).with_name('inset-method.smali').read_text(encoding='utf-8').rstrip('\n')
    if current == replacement:
        return False
    if hashlib.sha256(current.encode()).hexdigest() != ORIGINAL_SHA256:
        raise ValueError('Unknown inset callback: refusing to overwrite this Android version')
    path.write_text(source[:start] + replacement + source[end:], encoding='utf-8')
    return True


if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise SystemExit('Usage: python3 apply_keyboard_insets.py <apktool-project>')
    print('IME insets patched' if apply(sys.argv[1]) else 'Already patched')
