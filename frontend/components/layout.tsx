import Menu from "./Menu";
import { useRouter } from "next/router";
import Link from "next/link";

export default function Layout({ children }: { children:any }) {
  const router = useRouter();
  const showMenu = router.asPath !== "/login";

  return (
    <div style={{ display: "flex" }}>
      {showMenu && <Menu />}
      <div className="children">
        {showMenu && (
          <Link href="/info">
            <button id="info-btn" title="Info Page">
              I
            </button>
          </Link>
        )}
        {children}
      </div>
    </div>
  );
}
