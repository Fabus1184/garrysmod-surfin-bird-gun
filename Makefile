GMAD=/usr/bin/gmad
GMOD_PATH=~/.steam/steam/steamapps/common/GarrysMod

pack:
	$(GMAD) create -folder addon -out out/surfin_bird_gun.gma

copy:
	rm -rf $(GMOD_PATH)/garrysmod/addons/surfin_bird_gun || true
	cp -r addon $(GMOD_PATH)/garrysmod/addons/surfin_bird_gun
	
publish: out/surfin_bird_gun.gma
	$(GMOD_PATH)/bin/gmpublish_linux update \
		-id 3140398993 \
		-icon icon.jpeg \
		-addon out/surfin_bird_gun.gma