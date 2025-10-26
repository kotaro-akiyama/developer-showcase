"use client";

import Link from "next/link";
import type { CSSProperties } from "react";
import { siteConfig } from "../lib/site-config";

export default function Footer() {
  return (
    <footer style={styles.wrapper}>
      <div className="container" style={styles.inner}>
        <small style={styles.note}>{siteConfig.footerNote}</small>
        <nav>
          <ul style={styles.links}>
            <li>
              <Link href="/privacy" style={styles.link}>
                プライバシー
              </Link>
            </li>
            <li>
              <Link href="/terms" style={styles.link}>
                利用規約
              </Link>
            </li>
          </ul>
        </nav>
      </div>
    </footer>
  );
}

const styles: Record<string, CSSProperties> = {
  wrapper: {
    borderTop: "1px solid rgba(148, 163, 184, 0.3)",
    padding: "2rem 0",
    marginTop: "3rem",
  },
  inner: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    gap: "1rem",
    flexWrap: "wrap",
  },
  note: {
    fontSize: "0.85rem",
    color: "#94a3b8",
  },
  links: {
    display: "flex",
    gap: "1rem",
    listStyle: "none",
  },
  link: {
    fontSize: "0.85rem",
    color: "#cbd5f5",
  },
};
