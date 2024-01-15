GMAD=/usr/bin/gmad
GMOD_PATH=~/.steam/steam/steamapps/common/GarrysMod

pack:
	$(GMAD) create -folder addon -out out/surfin_bird_gun.gma

copy:
	rm -rf $(GMOD_PATH)/garrysmod/addons/surfin_bird_gun || true
	cp -r addon $(GMOD_PATH)/garrysmod/addons/surfin_bird_gun
	