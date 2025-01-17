import { ChevronRight, Book, Bird, House, Pin } from "lucide-react";

import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible";
import {
  Sidebar,
  SidebarGroup,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarMenuSub,
  SidebarMenuSubButton,
  SidebarMenuSubItem,
} from "@/components/ui/sidebar";
import { getTranslations } from "next-intl/server";
import Link from "next/link";

export default async function NavMain() {
  const t = await getTranslations("NavMain");
  return (
    <SidebarGroup>
      <SidebarMenu>
        {/* Home */}
        <SidebarMenuItem>
          <Link href="/">
            <SidebarMenuButton>
              <House />
              <span>{t("home")}</span>
            </SidebarMenuButton>
          </Link>
        </SidebarMenuItem>
        {/* Collapsible introduction */}
        <Collapsible asChild defaultOpen className="group/collapsible">
          <SidebarMenuItem>
            <CollapsibleTrigger asChild>
              <SidebarMenuButton>
                <Book />
                <span>{t("introduction")}</span>
                <ChevronRight className="ml-auto transition-transform duration-200 group-data-[state=open]/collapsible:rotate-90" />
              </SidebarMenuButton>
            </CollapsibleTrigger>
            <CollapsibleContent>
              <SidebarMenuSub>
                <SidebarMenuSubItem>
                  {/* subbutton 1 */}
                  <SidebarMenuSubButton asChild>
                    <a href="/">
                      <span>{t("whatIsBird")}</span>
                    </a>
                  </SidebarMenuSubButton>
                  {/* subbutton 2 */}
                  <SidebarMenuSubButton asChild>
                    <a href="/">
                      <span>{t("taxonomy")}</span>
                    </a>
                  </SidebarMenuSubButton>
                </SidebarMenuSubItem>
              </SidebarMenuSub>
            </CollapsibleContent>
          </SidebarMenuItem>
        </Collapsible>
        {/* Collapsible species */}
        <Collapsible asChild defaultOpen className="group/collapsible">
          <SidebarMenuItem>
            <CollapsibleTrigger asChild>
              <SidebarMenuButton>
                <Bird />
                <span>{t("species")}</span>
                <ChevronRight className="ml-auto transition-transform duration-200 group-data-[state=open]/collapsible:rotate-90" />
              </SidebarMenuButton>
            </CollapsibleTrigger>
            <CollapsibleContent>
              <SidebarMenuSub>
                <SidebarMenuSubItem>
                  {/* subbutton 1 */}
                  <SidebarMenuSubButton asChild>
                    <a href="/">
                      <span>{t("search")}</span>
                    </a>
                  </SidebarMenuSubButton>
                  {/* subbutton 2 */}
                  <SidebarMenuSubButton asChild>
                    <a href="/">
                      <span>{t("lastest")}</span>
                    </a>
                  </SidebarMenuSubButton>
                  {/* subbutton 3 */}
                  <SidebarMenuSubButton asChild>
                    <a href="/">
                      <span>{t("recentlyUpdated")}</span>
                    </a>
                  </SidebarMenuSubButton>
                  {/* subbutton 4 */}
                  <SidebarMenuSubButton asChild>
                    <a href="/">
                      <span>{t("specialsInThailand")}</span>
                    </a>
                  </SidebarMenuSubButton>
                </SidebarMenuSubItem>
              </SidebarMenuSub>
            </CollapsibleContent>
          </SidebarMenuItem>
        </Collapsible>
        {/* About us */}
        <SidebarMenuItem>
          <SidebarMenuButton>
            <Pin />
            <span>{t("aboutUs")}</span>
          </SidebarMenuButton>
        </SidebarMenuItem>
      </SidebarMenu>
    </SidebarGroup>
  );
}
