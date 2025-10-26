"use client";

import type { CSSProperties } from "react";

export default function GradientCallout() {
  return (
    <div style={styles.wrapper}>
      <div style={styles.card}>
        <p style={styles.title}>DXを引き上げる設計思想</p>
        <p style={styles.description}>
          明確なディレクトリ構造と型安全なデータフロー。UI、ビジネスロジック、インフラが心地よく分離され、保守コストを抑えながらスケールできます。
        </p>
      </div>
    </div>
  );
}

const styles: Record<string, CSSProperties> = {
  wrapper: {
    width: "100%",
    position: "relative",
    isolation: "isolate",
  },
  card: {
    padding: "1.5rem",
    borderRadius: "1.5rem",
    background:
      "linear-gradient(135deg, rgba(56, 189, 248, 0.18), rgba(129, 140, 248, 0.18))",
    backdropFilter: "blur(16px)",
    border: "1px solid rgba(148, 163, 184, 0.25)",
  },
  title: {
    fontWeight: 600,
    marginBottom: "0.5rem",
  },
  description: {
    color: "#cbd5f5",
    fontSize: "0.95rem",
    lineHeight: 1.7,
  },
};
