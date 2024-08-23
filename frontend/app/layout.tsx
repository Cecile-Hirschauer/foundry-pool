import "./globals.css";

import type { Metadata } from "next";
import { Inter as FontSans } from "next/font/google";

import { cn } from "@/lib/utils";

import CustomProvider from "./CustomProvider";

const fontSans = FontSans({
  subsets: ["latin"],
  variable: "--font-sans",
});

export const metadata: Metadata = {
  title: "Fooundry Pool",
  description: "Simple crowdfunding pool ",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head />
      <body
        className={cn(
          "min-h-screen dark bg-background font-sans antialiased",
          fontSans.variable
        )}
      >
        <CustomProvider>{children}</CustomProvider>
      </body>
    </html>
  );
}
