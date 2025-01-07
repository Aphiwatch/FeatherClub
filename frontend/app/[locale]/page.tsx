import {Link} from '@/i18n/routing';
import { getTranslations } from 'next-intl/server';
 
export default async function HomePage() {

  const t = await getTranslations('HomePage');
  return (
    <div className='text-8xl font-[family-name:var(--font-geistMono)]'>
      <h1>{t('title')}</h1>
      <Link href="/setting">{t('setting')}</Link>
    </div>
  );
}