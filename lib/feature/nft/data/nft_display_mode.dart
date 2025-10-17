enum NftDisplayMode {
  grid,
  list;

  static NftDisplayMode? byName(String name) => _byNameMap[name];
}

const _byNameMap = {'grid': NftDisplayMode.grid, 'list': NftDisplayMode.list};
