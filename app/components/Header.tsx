"use client";

import Link from "next/link";
import type { CSSProperties } from "react";
import { siteConfig } from "../lib/site-config";

type HeaderProps = {
  title: string;
};

export default function Header({ title }: HeaderProps) {
  return (
    <header className="container" style={styles.wrapper}>
      <Link href="/" style={styles.logo}>
        {title}
      </Link>
      <nav>
        <ul style={styles.navList}>
          {siteConfig.navLinks.map((link) => (
            <li key={link.href}>
              <Link href={link.href} style={styles.navLink}>
                {link.label}
              </Link>
            </li>
          ))}
        </ul>
      </nav>
    </header>
  );
}

const styles: Record<string, CSSProperties> = {
  wrapper: {
    display: "flex",
    alignItems: "center",
    justifyContent: "space-between",
    padding: "1.5rem 0",
  },
  logo: {
    fontWeight: 700,
    fontSize: "1.5rem",
  },
  navList: {
    display: "flex",
    gap: "1.5rem",
    listStyle: "none",
  },
  navLink: {
    fontSize: "0.95rem",
    color: "#cbd5f5",
    transition: "opacity 160ms ease",
  },
};
