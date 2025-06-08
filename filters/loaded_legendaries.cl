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

long filter(instance* inst) {
  init_locks(inst, 1, false, false);

  item firstTag = next_tag(inst, 1);
  item secondTag = next_tag(inst, 1);

  if (firstTag != Charm_Tag || secondTag != Charm_Tag) {
      return 0;
  }

  return next_charm_matches(inst) && next_charm_matches(inst);
}
