import Menu from "./Menu";
import { useRouter } from "next/router";

export default function Layout({ children }) {
  const router = useRouter();
  const showMenu = router.asPath !== "/login";

  return (
    <div style={{ display: "flex" }}>
      {showMenu ? <Menu /> : ""}
      <div className="children">{children}</div>
    </div>
  );
}
