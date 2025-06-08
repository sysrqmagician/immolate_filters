#include "lib/immolate.cl"

bool next_charm_matches(instance* inst) {
  item cards[5];
  arcana_pack(cards, 5, inst, 1);


  bool soul = false;
  bool temperance = false;

  for (int i = 0; i < 5; i++) {
    if (soul && temperance) return true;

    if (cards[i] == The_Soul) {
      soul = true;
      continue;
    }

    if (cards[i] == Temperance) {
      temperance = true;
      continue;
    }
  }

  return soul && temperance;
}

bool next_pack_has_soul(instance* inst) {
  item cards[5];

  pack _pack = pack_info(next_pack(inst, 1));
  if (_pack.type == Arcana_Pack) {
    arcana_pack(cards, _pack.size, inst, 1);
  } else if (_pack.type == Spectral_Pack) {
    spectral_pack(cards, _pack.size, inst, 1);
  } else return false;

  for (int i = 0; i < _pack.size; i++) {
    if (cards[i] == The_Soul) {
      return true;
    }
  }

  return false;
}

long filter(instance* inst) {
  init_locks(inst, 1, false, false);

  item firstTag = next_tag(inst, 1);
  item secondTag = next_tag(inst, 1);

  if (firstTag != Charm_Tag || secondTag != Charm_Tag) {
      return 0;
  }

  if (!next_charm_matches(inst) || !next_charm_matches(inst)) {
    return 0;
  } 
  
  // Skip Buffoon
  next_pack(inst, 1);

  return next_pack_has_soul(inst);
}
