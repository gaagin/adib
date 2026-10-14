/* Suspend idle network clients so Railway can scale down after 10 minutes. */
(function (root, factory) {
  'use strict';
  const api = factory();
  if (typeof module === 'object' && module.exports) module.exports = api;
  if (!root || !root.document) return;
  const busy = () => {
    try {
      const own = root.ADIBWork?.state?.own;
      if (Array.isArray(own) && own.some(s => s && (s.status === 'running' || s.status === 'pending'))) return true;
      if (root.ADIBPomodoroWindow?.isOpen) return true;
      return !!root.ADIBBrowserPomodoro?.activeId?.();
    } catch { return false; }
  };
  root.ADIBIdle = new api.NetworkIdle({
    window: root,
    document: root.document,
    idleMs: api.DEFAULT_IDLE_MS,
    isBusy: busy
  }).start();
})(typeof window === 'object' ? window : globalThis, function () {
  'use strict';
  const DEFAULT_IDLE_MS = 10 * 60 * 1000;
  const ACTIVITY_EVENTS = ['pointerdown', 'keydown', 'touchstart', 'wheel', 'input'];

  class NetworkIdle {
    constructor({ window: win, document: doc, idleMs = DEFAULT_IDLE_MS, isBusy = () => false, now = () => Date.now(), onState = null } = {}) {
      this.win = win || globalThis;
      this.doc = doc || this.win.document;
      this.idleMs = Math.max(1000, Number(idleMs) || DEFAULT_IDLE_MS);
      this.isBusy = isBusy;
      this.now = now;
      this.onState = onState;
      this.lastActivity = this.now();
      this.idle = !!this.doc?.hidden;
      this.started = false;
      this.timer = null;
      this.onActivity = () => this.markActivity('input');
      this.onVisibility = () => this.doc.hidden ? this.check() : this.markActivity('visible');
      this.onBusyChange = () => this.check();
    }

    start() {
      if (this.started || !this.doc) return this;
      this.started = true;
      for (const name of ACTIVITY_EVENTS) this.doc.addEventListener(name, this.onActivity, { passive: true });
      this.doc.addEventListener('visibilitychange', this.onVisibility);
      this.win.addEventListener?.('focus', this.onActivity);
      this.win.addEventListener?.('adib-work-data', this.onBusyChange);
      this.doc.addEventListener('adib-work-data', this.onBusyChange);
      if (this.idle) this.emit('hidden');
      else this.schedule();
      return this;
    }

    isIdle() { return this.idle; }
    isActive() { return !this.idle && !this.doc?.hidden; }
    isAwake() { return !this.idle; }

    markActivity(reason = 'input') {
      if (!this.started || this.doc?.hidden) return;
      this.lastActivity = this.now();
      if (this.idle) {
        this.idle = false;
        this.emit(reason);
      }
      this.schedule();
    }

    check() {
      if (!this.started) return;
      let busy = false;
      try { busy = !!this.isBusy(); } catch {}
      if (this.doc?.hidden && !busy) {
        if (!this.idle) { this.idle = true; this.emit('hidden'); }
        this.clearTimer();
        return;
      }
      const remaining = this.idleMs - (this.now() - this.lastActivity);
      if (!busy && remaining <= 0) {
        if (!this.idle) { this.idle = true; this.emit('timeout'); }
        this.clearTimer();
        return;
      }
      this.schedule(busy ? Math.min(60000, this.idleMs) : Math.max(1, remaining));
    }

    schedule(delay = this.idleMs - (this.now() - this.lastActivity)) {
      this.clearTimer();
      if (!this.started) return;
      this.timer = this.win.setTimeout(() => this.check(), Math.max(1, delay));
    }

    clearTimer() {
      if (this.timer !== null) this.win.clearTimeout(this.timer);
      this.timer = null;
    }

    emit(reason) {
      const detail = { idle: this.idle, active: this.isActive(), reason, idleMs: this.idleMs };
      this.onState?.(detail);
      const EventCtor = this.win.CustomEvent || globalThis.CustomEvent;
      if (EventCtor) this.win.dispatchEvent?.(new EventCtor('adib-network-idle', { detail }));
      else this.win.dispatchEvent?.({ type: 'adib-network-idle', detail });
    }

    destroy() {
      this.clearTimer();
      if (!this.started) return;
      for (const name of ACTIVITY_EVENTS) this.doc.removeEventListener(name, this.onActivity);
      this.doc.removeEventListener('visibilitychange', this.onVisibility);
      this.win.removeEventListener?.('focus', this.onActivity);
      this.win.removeEventListener?.('adib-work-data', this.onBusyChange);
      this.doc.removeEventListener('adib-work-data', this.onBusyChange);
      this.started = false;
    }
  }

  return { NetworkIdle, DEFAULT_IDLE_MS, ACTIVITY_EVENTS };
});
