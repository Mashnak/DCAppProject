import {Routes, RouterModule} from '@angular/router';
import {DetailpageComponent} from './detailpage/detailpage.component';

const appRoutes: Routes = [{
  path: 'add', component: DetailpageComponent
}];

export const routing = RouterModule.forRoot(appRoutes);
