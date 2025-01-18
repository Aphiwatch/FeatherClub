"use client";

import { ThemeProvider as NextThemesProvider } from "next-themes";
import { useEffect, useState } from "react";

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    // ป้องกันการเรนเดอร์ก่อน hydration เสร็จสมบูรณ์
    return <div style={{ visibility: "hidden" }}>{children}</div>;
  }

  return (
    <NextThemesProvider
      defaultTheme="system"
      enableSystem={true}
      attribute="class"
    >
      {children}
    </NextThemesProvider>
  );
}