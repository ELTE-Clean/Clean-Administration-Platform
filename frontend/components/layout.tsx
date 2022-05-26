import Menu from "./Menu";
import { useRouter } from "next/router";
import Link from "next/link";
import { useContext } from "react";
import { UserContext } from "../context/UserContext";

export default function Layout({ children }: { children: any }) {
  const { user } = useContext(UserContext);
  const router = useRouter();
  const showMenu = router.asPath !== "/login";
  const isUserLoggedIn = () => {
    return Object.keys(user).length > 0;
  };

  return (
    <div /* style={{ display: "flex" }}*/>
      {showMenu && <Menu />}
      <div className="children">
        {showMenu && (
          <Link href="/info" passHref>
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