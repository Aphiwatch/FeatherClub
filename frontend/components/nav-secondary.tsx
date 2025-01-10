import { LifeBuoy, Send } from "lucide-react";
import { Link } from "@/i18n/routing"; 
import {
  SidebarGroup,
  SidebarGroupContent,
  SidebarMenu,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import { getTranslations } from "next-intl/server";

export default async function NavSecondary() {
  const t = await getTranslations("NavSecondary");

  return (
    <SidebarGroup>
      <SidebarGroupContent>
        <SidebarMenu>
          {/* Support menu */}
          <SidebarMenuItem key="support">
           <Link
              href="/support"
              className="flex items-center space-x-2 p-2 cursor-pointer rounded-md transition-all duration-200 hover:bg-gray-100 hover:text-gray-900"
            >
              <LifeBuoy className="h-4 w-4" aria-hidden="true" />
              <span>{t("support")}</span>
            </Link>
          </SidebarMenuItem>

          {/* Feedback menu */}
          <SidebarMenuItem key="feedback">
            <Link
              href="/feedback"
              className="flex items-center space-x-2 p-2 cursor-pointer rounded-md transition-all duration-200 hover:bg-gray-100 hover:text-gray-900"
            >
              <Send className="h-4 w-4" aria-hidden="true" />
              <span>{t("feedback")}</span>
            </Link>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarGroupContent>
    </SidebarGroup>
  );
}
