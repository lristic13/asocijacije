// Shared phone-screen shell used by all three directions.
// Exports: Phone, StatusBar, HomeBar, Ico
const SCREEN_W = 320;
const SCREEN_H = 690;

function StatusBar({ color = "#fff", dim }) {
  const o = dim ? 0.85 : 1;
  return (
    <div style={{
      height: 34, display: "flex", alignItems: "center",
      justifyContent: "space-between", padding: "0 22px 0 26px",
      color, fontSize: 13, fontWeight: 700, letterSpacing: 0.2,
      flexShrink: 0, opacity: o, fontFamily: "'Hanken Grotesk', sans-serif",
    }}>
      <span>9:01</span>
      <div style={{ display: "flex", alignItems: "center", gap: 6 }}>
        {/* signal */}
        <svg width="17" height="11" viewBox="0 0 17 11" fill={color}><rect x="0" y="7" width="3" height="4" rx="1"/><rect x="4.5" y="5" width="3" height="6" rx="1"/><rect x="9" y="2.5" width="3" height="8.5" rx="1"/><rect x="13.5" y="0" width="3" height="11" rx="1"/></svg>
        {/* battery */}
        <svg width="25" height="12" viewBox="0 0 25 12" fill="none"><rect x="0.5" y="0.5" width="21" height="11" rx="3" stroke={color} opacity="0.5"/><rect x="2" y="2" width="16" height="8" rx="1.5" fill={color}/><rect x="23" y="4" width="1.5" height="4" rx="0.75" fill={color} opacity="0.5"/></svg>
      </div>
    </div>
  );
}

function HomeBar({ color = "#fff" }) {
  return (
    <div style={{ height: 22, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
      <div style={{ width: 120, height: 5, borderRadius: 3, background: color, opacity: 0.85 }} />
    </div>
  );
}

// Phone: fixed-size rounded screen. `bg` can be any CSS background.
function Phone({ bg, statusColor = "#fff", homeColor = "#fff", children, radius = 44, statusDim }) {
  return (
    <div style={{
      width: SCREEN_W, height: SCREEN_H, borderRadius: radius,
      background: bg, overflow: "hidden", position: "relative",
      display: "flex", flexDirection: "column",
      fontFamily: "'Hanken Grotesk', sans-serif",
    }}>
      <StatusBar color={statusColor} dim={statusDim} />
      <div style={{ flex: 1, minHeight: 0, display: "flex", flexDirection: "column", position: "relative" }}>
        {children}
      </div>
      <HomeBar color={homeColor} />
    </div>
  );
}

window.Phone = Phone;
window.StatusBar = StatusBar;
window.HomeBar = HomeBar;
window.SCREEN_W = SCREEN_W;
window.SCREEN_H = SCREEN_H;
