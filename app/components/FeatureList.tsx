"use client";

import type { CSSProperties } from "react";
import { featureList } from "../lib/features";

export default function FeatureList() {
  return (
    <section id="features" style={styles.wrapper}>
      <div className="container" style={styles.inner}>
        <div style={styles.copy}>
          <span style={styles.kicker}>Features</span>
          <h2 style={styles.heading}>
            開発と運用を両立する共通パターンを、最初から備えています。
          </h2>
          <p style={styles.summary}>
            ルートごとに機能を分割し、共有コンポーネントとフックで制御フローを統一。
            インフラ定義との一貫性も意識した設計です。
          </p>
        </div>
        <ul style={styles.list}>
          {featureList.map((feature) => (
            <li key={feature.title} style={styles.item}>
              <h3 style={styles.itemTitle}>{feature.title}</h3>
              <p style={styles.itemDescription}>{feature.description}</p>
              <span style={styles.itemHighlight}>{feature.highlight}</span>
            </li>
          ))}
        </ul>
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
    gap: "2.5rem",
  },
  copy: {
    display: "flex",
    flexDirection: "column",
    gap: "0.75rem",
    maxWidth: "46ch",
  },
  kicker: {
    fontSize: "0.85rem",
    fontWeight: 600,
    letterSpacing: "0.08em",
    textTransform: "uppercase",
    color: "#38bdf8",
  },
  heading: {
    fontSize: "2rem",
    fontWeight: 700,
    lineHeight: 1.25,
  },
  summary: {
    color: "#94a3b8",
    fontSize: "1rem",
    lineHeight: 1.7,
  },
  list: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(240px, 1fr))",
    gap: "1.5rem",
    listStyle: "none",
  },
  item: {
    padding: "1.5rem",
    borderRadius: "1.25rem",
    border: "1px solid rgba(148, 163, 184, 0.25)",
    background:
      "linear-gradient(135deg, rgba(15, 23, 42, 0.8), rgba(30, 41, 59, 0.85))",
  },
  itemTitle: {
    fontSize: "1.25rem",
    fontWeight: 600,
    marginBottom: "0.5rem",
  },
  itemDescription: {
    color: "#cbd5f5",
    fontSize: "0.95rem",
    lineHeight: 1.7,
    marginBottom: "0.75rem",
  },
  itemHighlight: {
    fontSize: "0.75rem",
    letterSpacing: "0.06em",
    textTransform: "uppercase",
    color: "#38bdf8",
  },
};
