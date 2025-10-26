"use client";

import type { CSSProperties } from "react";
import GradientCallout from "./GradientCallout";

export default function HeroSection() {
  return (
    <section style={styles.wrapper} id="hero">
      <div className="container" style={styles.inner}>
        <p style={styles.kicker}>Next.js + TypeScript</p>
        <h1 style={styles.heading}>
          アイデアをすぐに形へ。開発者体験を高めるスターターキット。
        </h1>
        <p style={styles.support}>
          再利用可能なUIコンポーネントと整備されたディレクトリ構造で、チーム開発でも迷わない。
          インフラコードとアプリケーションコードを一つのリポジトリで管理できます。
        </p>
        <div style={styles.ctaGroup}>
          <a href="#features" style={styles.primaryCta}>
            機能を確認
          </a>
          <a href="#contact" style={styles.secondaryCta}>
            デモを依頼
          </a>
        </div>
        <GradientCallout />
      </div>
    </section>
  );
}

const styles: Record<string, CSSProperties> = {
  wrapper: {
    paddingTop: "4rem",
    paddingBottom: "4rem",
  },
  inner: {
    display: "flex",
    flexDirection: "column",
    gap: "1.75rem",
    alignItems: "flex-start",
    position: "relative",
  },
  kicker: {
    fontSize: "0.85rem",
    fontWeight: 600,
    letterSpacing: "0.08em",
    textTransform: "uppercase",
    color: "#38bdf8",
  },
  heading: {
    fontSize: "2.5rem",
    fontWeight: 700,
    lineHeight: 1.25,
  },
  support: {
    fontSize: "1.05rem",
    color: "#94a3b8",
    maxWidth: "44ch",
  },
  ctaGroup: {
    display: "flex",
    gap: "1rem",
  },
  primaryCta: {
    background: "linear-gradient(135deg, #38bdf8, #818cf8)",
    color: "#0f172a",
    padding: "0.75rem 1.5rem",
    borderRadius: "999px",
    fontWeight: 600,
    boxShadow: "0 12px 30px rgba(56, 189, 248, 0.2)",
  },
  secondaryCta: {
    color: "#cbd5f5",
    padding: "0.75rem 1.5rem",
    borderRadius: "999px",
    border: "1px solid rgba(148, 163, 184, 0.4)",
  },
};
