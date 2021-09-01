const RootRoute = "/";
const ZcoinLinkRoute = "/zcoin_invite_link";

const OverViewDisplyName = 'Live OverView';
const OverViewPageRoute = '/overview';

const ReorderDisplyName = 'Re-Order';
const ReorderPageRoute = '/reorder';

const SalesDetailDisplayName = 'Detail Sales';
const SalesDetailPageRoute = '/detailsale';

const SearchItemDisplayName = 'Search Items';
const SearchItemPageRoute = '/search';
//
// const TutorialsDisplyName = 'Tutorials';
// const TutorialsPageRoute = '/Tutorials';
//
// const TopUpDisplyName = 'TopUp';
// const TopUpPageRoute = '/topup';
//
// const AuthenticationDisplyName = 'Log Out';
// const AuthenticationPageRoute = '/signin';

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(OverViewDisplyName, OverViewPageRoute),
  MenuItem(ReorderDisplyName, ReorderPageRoute),
  MenuItem(SalesDetailDisplayName, SalesDetailPageRoute),
  MenuItem(SearchItemDisplayName, SearchItemPageRoute),
];
