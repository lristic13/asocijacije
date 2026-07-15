// Direction A — Neon Arcade. Loud, glowing, game-show energy.
const naDisp = "'Fredoka', sans-serif";
const naBody = "'Hanken Grotesk', sans-serif";
const NA = {
  bg: "#0E0826", ink: "#FFFFFF", sub: "#A99FD6",
  orange: "#FC7753", magenta: "#FF4D8D", cyan: "#33E1CE",
  violet: "#8B7BE8", card: "#1B1442",
};
const naBg = `radial-gradient(120% 70% at 15% -5%, rgba(252,119,83,.22), transparent 55%), radial-gradient(120% 70% at 95% 105%, rgba(51,225,206,.16), transparent 55%), radial-gradient(90% 60% at 95% 0%, rgba(255,77,141,.14), transparent 60%), ${NA.bg}`;

function NaBtn({ color, dark, lip, glow, children, style, sub }) {
  return (
    <button style={{
      width: "100%", border: "none", borderRadius: 20, cursor: "pointer",
      padding: "15px 20px", fontFamily: naDisp, fontWeight: 600, fontSize: 19,
      color: dark ? "#1A0E2E" : "#fff", background: color, whiteSpace: "nowrap",
      boxShadow: `0 5px 0 ${lip}, 0 12px 26px ${glow}`,
      display: "flex", alignItems: "center", justifyContent: "center", gap: 9,
      ...style,
    }}>{children}</button>
  );
}

function NaGhost({ color, children, icon }) {
  return (
    <button style={{
      width: "100%", borderRadius: 18, cursor: "pointer", padding: "13px 18px",
      fontFamily: naDisp, fontWeight: 600, fontSize: 16, color,
      background: "rgba(255,255,255,.04)", border: `1.5px solid ${color}55`, whiteSpace: "nowrap",
      display: "flex", alignItems: "center", justifyContent: "center", gap: 9,
    }}>
      {icon}{children}
    </button>
  );
}

function NaLogo({ size = 50 }) {
  return (
    <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: size, lineHeight: 1, letterSpacing: -1.5, color: "#fff", textShadow: "0 0 28px rgba(252,119,83,.55)", whiteSpace: "nowrap" }}>
      Asocijacije<span style={{ color: NA.orange }}>.</span>
    </div>
  );
}

// ---- Home ----
function AHome() {
  return (
    <Phone bg={naBg}>
      <div style={{ flex: 1, display: "flex", flexDirection: "column", padding: "8px 26px 24px" }}>
        <div style={{ display: "flex", justifyContent: "center", gap: 6, background: "rgba(255,255,255,.05)", borderRadius: 30, padding: 4, width: "fit-content", margin: "0 auto" }}>
          {["Srpski", "English"].map((l, i) => (
            <span key={l} style={{ fontFamily: naBody, fontWeight: 700, fontSize: 13, padding: "6px 16px", borderRadius: 24, color: i ? "#1A0E2E" : NA.sub, background: i ? NA.orange : "transparent" }}>{l}</span>
          ))}
        </div>

        <div style={{ flex: 1, display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", gap: 14 }}>
          <div style={{ fontSize: 56, filter: "drop-shadow(0 0 22px rgba(255,77,141,.6))" }}>🎉</div>
          <NaLogo size={40} />
          <div style={{ fontFamily: naBody, fontWeight: 700, fontSize: 14.5, color: NA.cyan, letterSpacing: 0.2 }}>forget the paper, use the app!</div>
        </div>

        <div style={{ display: "flex", flexDirection: "column", gap: 13 }}>
          <NaBtn color={NA.orange} dark lip="#C9572F" glow="rgba(252,119,83,.45)" style={{ fontSize: 22, padding: "18px 20px" }}>
            <svg width="16" height="18" viewBox="0 0 16 18" fill="#1A0E2E"><path d="M0 1.5C0 .7.9.2 1.6.6l13 7.5c.6.4.6 1.4 0 1.8l-13 7.5C.9 17.8 0 17.3 0 16.5z"/></svg>
            Start game
          </NaBtn>
          <div style={{ display: "flex", gap: 11 }}>
            <NaGhost color={NA.cyan}>Instructions</NaGhost>
            <NaGhost color={NA.magenta}>Exit</NaGhost>
          </div>
        </div>
      </div>
    </Phone>
  );
}

// ---- Setup ----
function NaChip({ n, active }) {
  return (
    <div style={{
      flex: 1, borderRadius: 16, padding: "11px 0", textAlign: "center",
      background: active ? NA.orange : "rgba(255,255,255,.05)",
      border: active ? "none" : "1.5px solid rgba(255,255,255,.1)",
      boxShadow: active ? "0 0 22px rgba(252,119,83,.5)" : "none",
    }}>
      <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 22, color: active ? "#1A0E2E" : "#fff", lineHeight: 1 }}>{n}</div>
      <div style={{ fontFamily: naBody, fontWeight: 700, fontSize: 10, color: active ? "#1A0E2E" : NA.sub, marginTop: 2 }}>players</div>
    </div>
  );
}

function NaTeamCard({ name, color, players }) {
  return (
    <div style={{ borderRadius: 18, padding: 13, background: "rgba(255,255,255,.04)", border: `1.5px solid ${color}55`, boxShadow: `0 0 18px ${color}22` }}>
      <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 9 }}>
        <span style={{ width: 9, height: 9, borderRadius: 9, background: color, boxShadow: `0 0 10px ${color}` }} />
        <span style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 17, color: "#fff" }}>{name}</span>
      </div>
      <div style={{ display: "flex", gap: 8 }}>
        {players.map((p) => (
          <div key={p} style={{ flex: 1, fontFamily: naBody, fontWeight: 600, fontSize: 12.5, color: NA.sub, background: "rgba(0,0,0,.25)", borderRadius: 11, padding: "9px 11px" }}>{p}</div>
        ))}
      </div>
    </div>
  );
}

function ASetup() {
  return (
    <Phone bg={naBg}>
      <div style={{ flex: 1, display: "flex", flexDirection: "column", padding: "6px 22px 18px", gap: 13 }}>
        <div>
          <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 26, color: "#fff" }}>New game<span style={{ color: NA.orange }}>.</span></div>
          <div style={{ width: 40, height: 5, borderRadius: 4, background: NA.orange, marginTop: 4, boxShadow: "0 0 12px rgba(252,119,83,.6)" }} />
        </div>

        <div style={{ display: "flex", gap: 9 }}>
          <NaChip n="4" active /><NaChip n="6" /><NaChip n="8" /><NaChip n="10" />
        </div>

        <div style={{ display: "flex", gap: 10 }}>
          {["Normal", "Quick"].map((m, i) => (
            <div key={m} style={{ flex: 1, textAlign: "center", borderRadius: 14, padding: "12px 0", fontFamily: naDisp, fontWeight: 600, fontSize: 16, color: i ? NA.sub : "#1A0E2E", background: i ? "rgba(255,255,255,.05)" : NA.cyan, border: i ? "1.5px solid rgba(255,255,255,.1)" : "none", boxShadow: i ? "none" : "0 0 18px rgba(51,225,206,.4)" }}>{m}</div>
          ))}
        </div>

        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", background: "rgba(255,255,255,.04)", borderRadius: 14, padding: "11px 15px" }}>
          <span style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 15.5, color: "#fff" }}>Double points</span>
          <div style={{ width: 46, height: 26, borderRadius: 20, background: NA.orange, position: "relative", boxShadow: "0 0 16px rgba(252,119,83,.5)" }}>
            <span style={{ position: "absolute", right: 3, top: 3, width: 20, height: 20, borderRadius: 20, background: "#fff" }} />
          </div>
        </div>

        <div style={{ display: "flex", gap: 8 }}>
          {[["Normal", "45s"], ["One word", "45s"], ["Mime", "60s"]].map(([a, b]) => (
            <div key={a} style={{ flex: 1, textAlign: "center", borderRadius: 12, padding: "8px 0", background: "rgba(255,255,255,.04)" }}>
              <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 17, color: NA.cyan }}>{b}</div>
              <div style={{ fontFamily: naBody, fontWeight: 700, fontSize: 10, color: NA.sub }}>{a}</div>
            </div>
          ))}
        </div>

        <NaTeamCard name="Team Alpha" color={NA.magenta} players={["Player 1", "Player 2"]} />
        <NaTeamCard name="Team Beta" color={NA.cyan} players={["Player 3", "Player 4"]} />

        <div style={{ flex: 1 }} />
        <div style={{ display: "flex", gap: 11 }}>
          <div style={{ flex: 1 }}><NaGhost color="#fff">Back</NaGhost></div>
          <div style={{ flex: 1.4 }}><NaBtn color={NA.orange} dark lip="#C9572F" glow="rgba(252,119,83,.45)">Next →</NaBtn></div>
        </div>
      </div>
    </Phone>
  );
}

// ---- Play ----
function ARing({ value = 10, pct = 0.78 }) {
  const r = 58, c = 2 * Math.PI * r;
  return (
    <div style={{ position: "relative", width: 142, height: 142 }}>
      <svg width="142" height="142" viewBox="0 0 142 142" style={{ transform: "rotate(-90deg)" }}>
        <circle cx="71" cy="71" r={r} fill="none" stroke="rgba(255,255,255,.08)" strokeWidth="11" />
        <circle cx="71" cy="71" r={r} fill="none" stroke={NA.orange} strokeWidth="11" strokeLinecap="round" strokeDasharray={c} strokeDashoffset={c * (1 - pct)} style={{ filter: "drop-shadow(0 0 8px rgba(252,119,83,.8))" }} />
      </svg>
      <div style={{ position: "absolute", inset: 0, display: "flex", alignItems: "center", justifyContent: "center", fontFamily: naDisp, fontWeight: 600, fontSize: 50, color: "#fff" }}>{value}</div>
    </div>
  );
}

function APlay() {
  return (
    <Phone bg={naBg}>
      <div style={{ flex: 1, display: "flex", flexDirection: "column", padding: "8px 24px 18px" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}>
          <div>
            <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 20, color: "#fff", whiteSpace: "nowrap" }}>Normal round<span style={{ color: NA.orange }}>.</span></div>
            <div style={{ width: 36, height: 5, borderRadius: 4, background: NA.orange, marginTop: 3 }} />
          </div>
          <span style={{ width: 30, height: 30, borderRadius: 30, border: `1.5px solid ${NA.sub}`, color: NA.sub, display: "flex", alignItems: "center", justifyContent: "center", fontFamily: naBody, fontWeight: 700, fontSize: 14 }}>i</span>
        </div>

        <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: 22, marginTop: 18 }}>
          <ARing value={10} pct={0.78} />
          <div style={{ textAlign: "center" }}>
            <div style={{ fontFamily: naBody, fontWeight: 800, fontSize: 14, color: NA.sub, letterSpacing: 1, textTransform: "uppercase" }}>Score</div>
            <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 56, color: NA.cyan, lineHeight: 1, textShadow: "0 0 22px rgba(51,225,206,.5)" }}>3</div>
          </div>
        </div>

        <div style={{ textAlign: "center", marginTop: 12 }}>
          <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 19, color: "#fff" }}>Team Alpha</div>
          <div style={{ fontFamily: naBody, fontWeight: 700, fontSize: 13, color: NA.sub, marginTop: 2 }}>Player 1 <span style={{ color: NA.orange }}>→</span> Player 2</div>
        </div>

        <div style={{ flex: 1, display: "flex", alignItems: "center", justifyContent: "center", margin: "14px 0" }}>
          <div style={{ width: "100%", padding: "44px 20px", borderRadius: 24, textAlign: "center", background: "linear-gradient(150deg, #2A1E5C, #1B1442)", border: `1.5px solid ${NA.violet}66`, boxShadow: "0 0 36px rgba(139,123,232,.3), inset 0 1px 0 rgba(255,255,255,.08)" }}>
            <div style={{ fontFamily: naBody, fontWeight: 800, fontSize: 11, color: NA.violet, letterSpacing: 2, textTransform: "uppercase", marginBottom: 10 }}>Explain this</div>
            <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 38, color: "#fff", textShadow: "0 0 24px rgba(255,255,255,.25)" }}>Hamburger</div>
          </div>
        </div>

        <div style={{ display: "flex", gap: 11 }}>
          <div style={{ flex: 1 }}><NaGhost color={NA.magenta}>Give up</NaGhost></div>
          <div style={{ flex: 1.3 }}><NaBtn color={NA.cyan} dark lip="#1FAE9E" glow="rgba(51,225,206,.45)">✓ Got it</NaBtn></div>
        </div>
      </div>
    </Phone>
  );
}

// ---- Scoreboard ----
function AScoreRow({ name, players, score, color, lead }) {
  return (
    <div style={{ position: "relative", borderRadius: 20, padding: "18px 20px", display: "flex", alignItems: "center", justifyContent: "space-between", background: lead ? `linear-gradient(120deg, ${color}28, rgba(255,255,255,.03))` : "rgba(255,255,255,.04)", border: `1.5px solid ${lead ? color : "rgba(255,255,255,.1)"}`, boxShadow: lead ? `0 0 26px ${color}33` : "none" }}>
      {lead && <span style={{ position: "absolute", top: -12, left: 18, fontSize: 22 }}>👑</span>}
      <div style={{ minWidth: 0 }}>
        <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 22, color: "#fff", whiteSpace: "nowrap" }}>{name}</div>
        <div style={{ fontFamily: naBody, fontWeight: 600, fontSize: 12.5, color: NA.sub, marginTop: 2, whiteSpace: "nowrap" }}>{players}</div>
      </div>
      <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 44, color: lead ? color : "#fff", lineHeight: 1, textShadow: lead ? `0 0 20px ${color}88` : "none" }}>{score}</div>
    </div>
  );
}

function AScore() {
  return (
    <Phone bg={naBg}>
      <div style={{ flex: 1, display: "flex", flexDirection: "column", padding: "10px 24px 18px" }}>
        <div style={{ textAlign: "center", marginTop: 8 }}>
          <div style={{ fontSize: 38 }}>🏆</div>
          <div style={{ fontFamily: naDisp, fontWeight: 600, fontSize: 30, color: "#fff", marginTop: 4 }}>Scoreboard<span style={{ color: NA.orange }}>.</span></div>
        </div>
        <div style={{ display: "flex", flexDirection: "column", gap: 16, marginTop: 30 }}>
          <AScoreRow name="Team Alpha" players="Player 1 · Player 2" score="4" color={NA.magenta} lead />
          <AScoreRow name="Team Beta" players="Player 3 · Player 4" score="0" color={NA.cyan} />
        </div>
        <div style={{ flex: 1 }} />
        <div style={{ textAlign: "center", fontFamily: naDisp, fontWeight: 600, fontSize: 17, color: "#fff", marginBottom: 14 }}>
          Up next: <span style={{ color: NA.cyan }}>Team Beta</span> 🎤
        </div>
        <NaBtn color={NA.orange} dark lip="#C9572F" glow="rgba(252,119,83,.45)" style={{ fontSize: 21, padding: "17px 20px" }}>Next round →</NaBtn>
      </div>
    </Phone>
  );
}

Object.assign(window, { AHome, ASetup, APlay, AScore });
