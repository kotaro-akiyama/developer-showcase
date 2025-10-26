import "./globals.css";
import type { ReactNode } from "react";
import Footer from "./components/Footer";
import Header from "./components/Header";
import { siteConfig } from "./lib/site-config";

export const metadata = {
  title: siteConfig.title,
  description: siteConfig.description,
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="ja">
      <body className="app-shell">
        <Header title={siteConfig.title} />
        <main className="app-main">
          <div className="container">{children}</div>
        </main>
        <Footer />
      </body>
    </html>
  );
}
