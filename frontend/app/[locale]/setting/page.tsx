import  AppSidebar  from '@/components/app-sidebar'
import { SidebarProvider } from '@/components/ui/sidebar'
import React from 'react'

export default function SettingPage(){
    return (
        <>
        <SidebarProvider>
            <AppSidebar />
            <h1>Setting Page</h1>
        </SidebarProvider>
        
        </>
    )
}
