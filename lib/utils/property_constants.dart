const List<String> typeList = ['For Rent', 'For Sale'];

const List<String> categoryList = [
  'Apartment',
  'Townhouse',
  'Single Family',
  'Condo',
  'Multi Family',
  'Villa',
];

const List<String> listingList = ['Owner', 'Agent'];

const List<int> bedroomsList = [0, 1, 2, 3, 4, 5, 6];

const List<int> bathroomsList = [0, 1, 2, 3, 4];

const List<String> priceList = ['Min', 'Max'];

enum SortBy { defaultSort, priceLowToHigh, priceHighToLow }

const Map<SortBy, String> sortByLabels = {
  SortBy.defaultSort: 'Default',
  SortBy.priceLowToHigh: 'Price: Low to High',
  SortBy.priceHighToLow: 'Price: High to Low',
};
