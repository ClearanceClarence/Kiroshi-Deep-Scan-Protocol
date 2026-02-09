// Housing and living situations
public abstract class TextHousing {
    // === HOMELESS / STREET ===
    public static func LIVED_ALLEY_F() -> String { return "Lived in an alley. "; }
    public static func LIVED_ALLEY_M() -> String { return ""; }
    public static func LIVED_DMPSTR_F() -> String { return "Lived in a dumpster. "; }
    public static func LIVED_DMPSTR_M() -> String { return ""; }
    public static func LIVED_DRNPIPE_F() -> String { return "Lived in a drainpipe. "; }
    public static func LIVED_DRNPIPE_M() -> String { return ""; }
    public static func LIVED_GUTTR_F() -> String { return "Lived in a gutter. "; }
    public static func LIVED_GUTTR_M() -> String { return ""; }
    public static func LIVED_SEWER_F() -> String { return "Lived in a sewer. "; }
    public static func LIVED_SEWER_M() -> String { return ""; }
    public static func LIVED_ABN_CAR_F() -> String { return "Lived in an abandoned car. "; }
    public static func LIVED_ABN_CAR_M() -> String { return ""; }
    public static func LIVED_VAN_F() -> String { return "Lived in a van. "; }
    public static func LIVED_VAN_M() -> String { return ""; }
    public static func LIVED_BOX_F() -> String { return "Lived in a cardboard box. "; }
    public static func LIVED_BOX_M() -> String { return ""; }
    public static func LIVED_TENT_FRWY_F() -> String { return "Lived in a tent under the freeway. "; }
    public static func LIVED_TENT_FRWY_M() -> String { return ""; }
    public static func LIVED_UDR_BRIDGE_F() -> String { return "Lived under a bridge. "; }
    public static func LIVED_UDR_BRIDGE_M() -> String { return ""; }
    public static func LIVED_RDS_CAR_F() -> String { return "Lived in a car on the roadside. "; }
    public static func LIVED_RDS_CAR_M() -> String { return ""; }
    public static func LIVED_CONTAINER_F() -> String { return "Lived in a converted shipping container. "; }
    public static func LIVED_CONTAINER_M() -> String { return ""; }
    public static func LIVED_ROOFTOP_F() -> String { return "Lived in a makeshift shelter on a rooftop. "; }
    public static func LIVED_ROOFTOP_M() -> String { return ""; }
    public static func LIVED_FACTORY_F() -> String { return "Squatted in an abandoned factory. "; }
    public static func LIVED_FACTORY_M() -> String { return ""; }
    public static func LIVED_METRO_F() -> String { return "Lived in the abandoned metro tunnels. "; }
    public static func LIVED_METRO_M() -> String { return ""; }
    public static func LIVED_CONSTR_F() -> String { return "Squatted in an unfinished construction site. "; }
    public static func LIVED_CONSTR_M() -> String { return ""; }

    // === DANGEROUS / CRIME AREAS ===
    public static func LIVED_COMBAT_ZONE_F() -> String { return "Lived in the heart of the Combat Zone. "; }
    public static func LIVED_COMBAT_ZONE_M() -> String { return ""; }
    public static func LIVED_CHEM_DEN_F() -> String { return "Lived in a chem den. "; }
    public static func LIVED_CHEM_DEN_M() -> String { return ""; }
    public static func LIVED_CRM_HOOD_F() -> String { return "Lived in a crime-ridden neighborhood in Night City. "; }
    public static func LIVED_CRM_HOOD_M() -> String { return ""; }
    public static func LIVED_GNG_BANDIT_F() -> String { return "Lived among a gang of bandits. "; }
    public static func LIVED_GNG_BANDIT_M() -> String { return ""; }
    public static func LIVED_MAELSTROM_F() -> String { return "Lived in Maelstrom-controlled territory. "; }
    public static func LIVED_MAELSTROM_M() -> String { return ""; }
    public static func LIVED_TYGER_F() -> String { return "Lived in Tyger Claws territory. "; }
    public static func LIVED_TYGER_M() -> String { return ""; }
    public static func LIVED_VALENTINO_F() -> String { return "Lived in Valentinos territory. "; }
    public static func LIVED_VALENTINO_M() -> String { return ""; }
    public static func LIVED_6TH_ST_F() -> String { return "Lived in 6th Street territory. "; }
    public static func LIVED_6TH_ST_M() -> String { return ""; }
    public static func LIVED_ANIMALS_F() -> String { return "Lived in The Animals territory. "; }
    public static func LIVED_ANIMALS_M() -> String { return ""; }
    public static func LIVED_VDB_F() -> String { return "Lived in Voodoo Boys territory in Pacifica. "; }
    public static func LIVED_VDB_M() -> String { return ""; }
    public static func LIVED_SCAV_F() -> String { return "Lived near a Scav operation. "; }
    public static func LIVED_SCAV_M() -> String { return ""; }

    // === LOW-INCOME / WORKING CLASS ===
    public static func LIVED_APT_MGTWR_F() -> String { return "Lived in an apartment in a megatower. "; }
    public static func LIVED_APT_MGTWR_M() -> String { return ""; }
    public static func LIVED_JNTR_MGTWR_F() -> String { return "Lived in a janitor's closet in a megatower. "; }
    public static func LIVED_JNTR_MGTWR_M() -> String { return ""; }
    public static func LIVED_MULTI_FAM_F() -> String { return "Lived in a multi-family home in Night City. "; }
    public static func LIVED_MULTI_FAM_M() -> String { return ""; }
    public static func LIVED_SHED_INDSTR_F() -> String { return "Lived in a shed in an industrial district. "; }
    public static func LIVED_SHED_INDSTR_M() -> String { return ""; }
    public static func LIVED_SHANTY_F() -> String { return "Lived in a favela shanty in Night City. "; }
    public static func LIVED_SHANTY_M() -> String { return ""; }
    public static func LIVED_CRAP_TWNHME_F() -> String { return "Lived in a crummy townhome apartment in Night City. "; }
    public static func LIVED_CRAP_TWNHME_M() -> String { return ""; }
    public static func LIVED_RANCHO_HOUSE_F() -> String { return "Lived in a run-down house in Rancho Coronado. "; }
    public static func LIVED_RANCHO_HOUSE_M() -> String { return ""; }
    public static func LIVED_DECAY_HOOD_F() -> String { return "Lived in a decaying, once upscale neighborhood. "; }
    public static func LIVED_DECAY_HOOD_M() -> String { return ""; }
    public static func LIVED_ABV_LAUND_F() -> String { return "Lived above a laundromat in Night City. "; }
    public static func LIVED_ABV_LAUND_M() -> String { return ""; }
    public static func LIVED_ABV_BAR_F() -> String { return "Lived above a bar in Night City. "; }
    public static func LIVED_ABV_BAR_M() -> String { return ""; }
    public static func LIVED_MHOME_FRWY_F() -> String { return "Lived in a mobile home along the freeway. "; }
    public static func LIVED_MHOME_FRWY_M() -> String { return ""; }
    public static func LIVED_COFFIN_F() -> String { return "Lived in a coffin hotel. "; }
    public static func LIVED_COFFIN_M() -> String { return ""; }
    public static func LIVED_CUBE_F() -> String { return "Lived permanently in a cube hotel. "; }
    public static func LIVED_CUBE_M() -> String { return ""; }
    public static func LIVED_H4_F() -> String { return "Lived in Megabuilding H4 in Little China. "; }
    public static func LIVED_H4_M() -> String { return ""; }
    public static func LIVED_H10_F() -> String { return "Lived in Megabuilding H10 in Watson. "; }
    public static func LIVED_H10_M() -> String { return ""; }
    public static func LIVED_ARROYO_F() -> String { return "Lived in the Arroyo district. "; }
    public static func LIVED_ARROYO_M() -> String { return ""; }
    public static func LIVED_KABUKI_F() -> String { return "Lived in Kabuki. "; }
    public static func LIVED_KABUKI_M() -> String { return ""; }
    public static func LIVED_GLEN_F() -> String { return "Lived in The Glen. "; }
    public static func LIVED_GLEN_M() -> String { return ""; }
    public static func LIVED_JAPANTOWN_F() -> String { return "Lived in Japantown. "; }
    public static func LIVED_JAPANTOWN_M() -> String { return ""; }
    public static func LIVED_CHARTER_F() -> String { return "Lived in Charter Hill. "; }
    public static func LIVED_CHARTER_M() -> String { return ""; }
    public static func LIVED_VISTA_F() -> String { return "Lived in Vista del Rey. "; }
    public static func LIVED_VISTA_M() -> String { return ""; }
    public static func LIVED_WELLSPRINGS_F() -> String { return "Lived in Wellsprings. "; }
    public static func LIVED_WELLSPRINGS_M() -> String { return ""; }

    // === NOMAD / BADLANDS ===
    public static func LIVED_TENT_WASTES_F() -> String { return "Lived in a tent in the wastes. "; }
    public static func LIVED_TENT_WASTES_M() -> String { return ""; }
    public static func LIVED_NOMAD_PACK_F() -> String { return "Lived in a nomad pack moving from city to city. "; }
    public static func LIVED_NOMAD_PACK_M() -> String { return ""; }
    public static func LIVED_SHACK_F() -> String { return "Lived in a tar-paper shack in the burning badlands far from the city. "; }
    public static func LIVED_SHACK_M() -> String { return ""; }

    // Expanded Housing - Nomad Living
    public static func LIVED_RV_F() -> String { return "Grew up in an RV in the badlands. "; }
    public static func LIVED_RV_M() -> String { return "Grew up in an RV in the badlands. "; }
    public static func LIVED_CONVOY_F() -> String { return "Grew up traveling with a nomad convoy. "; }
    public static func LIVED_CONVOY_M() -> String { return "Grew up traveling with a nomad convoy. "; }
    public static func LIVED_MOBILE_BASE_F() -> String { return "Grew up in a mobile base. "; }
    public static func LIVED_MOBILE_BASE_M() -> String { return "Grew up in a mobile base. "; }
    public static func LIVED_BASILISK_F() -> String { return "Grew up in a converted Basilisk tank. "; }
    public static func LIVED_BASILISK_M() -> String { return "Grew up in a converted Basilisk tank. "; }
    public static func LIVED_TRUCK_STOP_F() -> String { return "Grew up at a truck stop in the badlands. "; }
    public static func LIVED_TRUCK_STOP_M() -> String { return "Grew up at a truck stop in the badlands. "; }
    public static func LIVED_REST_STOP_F() -> String { return "Grew up at a rest stop. "; }
    public static func LIVED_REST_STOP_M() -> String { return "Grew up at a rest stop. "; }
    public static func LIVED_OILFIELD_F() -> String { return "Grew up near an oilfield camp. "; }
    public static func LIVED_OILFIELD_M() -> String { return "Grew up near an oilfield camp. "; }
    public static func LIVED_SOLAR_FARM_F() -> String { return "Grew up near a solar farm. "; }
    public static func LIVED_SOLAR_FARM_M() -> String { return "Grew up near a solar farm. "; }
    public static func LIVED_WIND_FARM_F() -> String { return "Grew up near a wind farm. "; }
    public static func LIVED_WIND_FARM_M() -> String { return "Grew up near a wind farm. "; }
    public static func LIVED_BORDER_TOWN_F() -> String { return "Grew up in a border town. "; }
    public static func LIVED_BORDER_TOWN_M() -> String { return "Grew up in a border town. "; }
    // Expanded Housing - Underground
    public static func LIVED_BUNKER_F() -> String { return "Grew up in an underground bunker. "; }
    public static func LIVED_BUNKER_M() -> String { return "Grew up in an underground bunker. "; }
    public static func LIVED_BASEMENT_F() -> String { return "Grew up in a basement apartment. "; }
    public static func LIVED_BASEMENT_M() -> String { return "Grew up in a basement apartment. "; }
    public static func LIVED_UTILITY_F() -> String { return "Grew up in utility tunnels. "; }
    public static func LIVED_UTILITY_M() -> String { return "Grew up in utility tunnels. "; }
    public static func LIVED_PARKING_F() -> String { return "Grew up in an underground parking garage. "; }
    public static func LIVED_PARKING_M() -> String { return "Grew up in an underground parking garage. "; }
    public static func LIVED_CATACOMB_F() -> String { return "Grew up in old catacombs beneath the city. "; }
    public static func LIVED_CATACOMB_M() -> String { return "Grew up in old catacombs beneath the city. "; }
    // Expanded Housing - Gang Territory
    public static func LIVED_GANG_TURF_F() -> String { return "Grew up on gang turf. "; }
    public static func LIVED_GANG_TURF_M() -> String { return "Grew up on gang turf. "; }
    public static func LIVED_WAR_ZONE_F() -> String { return "Grew up in a gang war zone. "; }
    public static func LIVED_WAR_ZONE_M() -> String { return "Grew up in a gang war zone. "; }
    public static func LIVED_RED_ZONE_F() -> String { return "Grew up in a red zone combat area. "; }
    public static func LIVED_RED_ZONE_M() -> String { return "Grew up in a red zone combat area. "; }
    public static func LIVED_CHEM_ZONE_F() -> String { return "Grew up near a chemical contamination zone. "; }
    public static func LIVED_CHEM_ZONE_M() -> String { return "Grew up near a chemical contamination zone. "; }
    public static func LIVED_RADIATION_F() -> String { return "Grew up in a radiation-affected area. "; }
    public static func LIVED_RADIATION_M() -> String { return "Grew up in a radiation-affected area. "; }
    public static func LIVED_SCAV_TERR_F() -> String { return "Grew up in Scav territory. "; }
    public static func LIVED_SCAV_TERR_M() -> String { return "Grew up in Scav territory. "; }
    public static func LIVED_6TH_ST_F() -> String { return "Grew up in 6th Street territory. "; }
    public static func LIVED_6TH_ST_M() -> String { return "Grew up in 6th Street territory. "; }
    public static func LIVED_VOODOO_F() -> String { return "Grew up in Voodoo Boys territory. "; }
    public static func LIVED_VOODOO_M() -> String { return "Grew up in Voodoo Boys territory. "; }
    // Expanded Housing - Institutional
    public static func LIVED_HOSPITAL_F() -> String { return "Spent much of childhood in hospitals. "; }
    public static func LIVED_HOSPITAL_M() -> String { return "Spent much of childhood in hospitals. "; }
    public static func LIVED_PSYCH_WARD_F() -> String { return "Grew up in a psychiatric facility. "; }
    public static func LIVED_PSYCH_WARD_M() -> String { return "Grew up in a psychiatric facility. "; }
    public static func LIVED_REHAB_F() -> String { return "Spent time in juvenile rehabilitation. "; }
    public static func LIVED_REHAB_M() -> String { return "Spent time in juvenile rehabilitation. "; }
    public static func LIVED_JUVENILE_F() -> String { return "Grew up in juvenile detention. "; }
    public static func LIVED_JUVENILE_M() -> String { return "Grew up in juvenile detention. "; }
    public static func LIVED_PRISON_F() -> String { return "Spent formative years in prison. "; }
    public static func LIVED_PRISON_M() -> String { return "Spent formative years in prison. "; }
    public static func LIVED_HALFWAY_F() -> String { return "Lived in a halfway house. "; }
    public static func LIVED_HALFWAY_M() -> String { return "Lived in a halfway house. "; }
    public static func LIVED_MILITARY_BASE_F() -> String { return "Grew up on a military base. "; }
    public static func LIVED_MILITARY_BASE_M() -> String { return "Grew up on a military base. "; }
    public static func LIVED_BARRACKS_F() -> String { return "Grew up in military barracks. "; }
    public static func LIVED_BARRACKS_M() -> String { return "Grew up in military barracks. "; }
    // Expanded Housing - Unconventional
    public static func LIVED_BOAT_F() -> String { return "Grew up on a boat. "; }
    public static func LIVED_BOAT_M() -> String { return "Grew up on a boat. "; }
    public static func LIVED_HOUSEBOAT_F() -> String { return "Grew up on a houseboat. "; }
    public static func LIVED_HOUSEBOAT_M() -> String { return "Grew up on a houseboat. "; }
    public static func LIVED_CONSTRUCTION_F() -> String { return "Grew up in an abandoned construction site. "; }
    public static func LIVED_CONSTRUCTION_M() -> String { return "Grew up in an abandoned construction site. "; }
    public static func LIVED_WAREHOUSE_F() -> String { return "Grew up in an abandoned warehouse. "; }
    public static func LIVED_WAREHOUSE_M() -> String { return "Grew up in an abandoned warehouse. "; }
    public static func LIVED_OFFICE_F() -> String { return "Grew up in an abandoned office building. "; }
    public static func LIVED_OFFICE_M() -> String { return "Grew up in an abandoned office building. "; }
    public static func LIVED_MALL_F() -> String { return "Grew up in an abandoned mall. "; }
    public static func LIVED_MALL_M() -> String { return "Grew up in an abandoned mall. "; }
    public static func LIVED_SCHOOL_F() -> String { return "Grew up squatting in an abandoned school. "; }
    public static func LIVED_SCHOOL_M() -> String { return "Grew up squatting in an abandoned school. "; }
    public static func LIVED_CHURCH_F() -> String { return "Grew up in an abandoned church. "; }
    public static func LIVED_CHURCH_M() -> String { return "Grew up in an abandoned church. "; }
    public static func LIVED_STADIUM_F() -> String { return "Grew up in an abandoned stadium. "; }
    public static func LIVED_STADIUM_M() -> String { return "Grew up in an abandoned stadium. "; }
    public static func LIVED_AMUSEMENT_F() -> String { return "Grew up in an abandoned amusement park. "; }
    public static func LIVED_AMUSEMENT_M() -> String { return "Grew up in an abandoned amusement park. "; }
    public static func LIVED_STORAGE_F() -> String { return "Grew up in a storage unit. "; }
    public static func LIVED_STORAGE_M() -> String { return "Grew up in a storage unit. "; }
    public static func LIVED_MOTEL_F() -> String { return "Grew up in a run-down motel. "; }
    public static func LIVED_MOTEL_M() -> String { return "Grew up in a run-down motel. "; }
    public static func LIVED_NO_TELL_F() -> String { return "Grew up in a No-Tell Motel. "; }
    public static func LIVED_NO_TELL_M() -> String { return "Grew up in a No-Tell Motel. "; }
    public static func LIVED_NOMAD_CAMP_F() -> String { return "Lived in a nomad camp outside the city. "; }
    public static func LIVED_NOMAD_CAMP_M() -> String { return ""; }
    public static func LIVED_ROCKY_F() -> String { return "Lived near Rocky Ridge in the badlands. "; }
    public static func LIVED_ROCKY_M() -> String { return ""; }
    public static func LIVED_BIOTECH_FLATS_F() -> String { return "Lived near the Biotechnica Flats. "; }
    public static func LIVED_BIOTECH_FLATS_M() -> String { return ""; }
    public static func LIVED_JACKSON_F() -> String { return "Lived in the Jackson Plains. "; }
    public static func LIVED_JACKSON_M() -> String { return ""; }
    public static func LIVED_MOBILE_F() -> String { return "Lived a mobile life in convoy vehicles. "; }
    public static func LIVED_MOBILE_M() -> String { return ""; }
    public static func LIVED_SMUGGLER_F() -> String { return "Lived at a smuggler's outpost in the badlands. "; }
    public static func LIVED_SMUGGLER_M() -> String { return ""; }

    // === MIDDLE CLASS ===
    public static func LIVED_SMLL_TOWN_F() -> String { return "Lived in a small town far from the city. "; }
    public static func LIVED_SMLL_TOWN_M() -> String { return ""; }
    public static func LIVED_NICE_TWNHME_F() -> String { return "Lived in a nice townhouse in Night City. "; }
    public static func LIVED_NICE_TWNHME_M() -> String { return ""; }
    public static func LIVED_VILLAGE_F() -> String { return "Lived in a village far from the city. "; }
    public static func LIVED_VILLAGE_M() -> String { return ""; }
    public static func LIVED_LUDDITE_F() -> String { return "Moved into a luddite commune. "; }
    public static func LIVED_LUDDITE_M() -> String { return ""; }
    public static func LIVED_HEYWOOD_F() -> String { return "Lived in a decent apartment in Heywood. "; }
    public static func LIVED_HEYWOOD_M() -> String { return ""; }
    public static func LIVED_SANTO_F() -> String { return "Lived in Santo Domingo. "; }
    public static func LIVED_SANTO_M() -> String { return ""; }
    public static func LIVED_GATED_F() -> String { return "Lived in a gated community outside Night City. "; }
    public static func LIVED_GATED_M() -> String { return ""; }

    // === WEALTHY / CORPORATE ===
    public static func LIVED_LXR_MGTWR_F() -> String { return "Lived in a luxury megatower. "; }
    public static func LIVED_LXR_MGTWR_M() -> String { return ""; }
    public static func LIVED_CRP_SBRB_F() -> String { return "Lived in a safe corpo suburbia. "; }
    public static func LIVED_CRP_SBRB_M() -> String { return ""; }
    public static func LIVED_CRP_ZONE_F() -> String { return "Lived in a defended corpo zone in Night City. "; }
    public static func LIVED_CRP_ZONE_M() -> String { return ""; }
    public static func LIVED_CRP_RSRCH_F() -> String { return "Lived in a corpo controlled research facility. "; }
    public static func LIVED_CRP_RSRCH_M() -> String { return ""; }
    public static func LIVED_CRP_FARM_F() -> String { return "Lived on a corpo controlled farm. "; }
    public static func LIVED_CRP_FARM_M() -> String { return ""; }
    public static func LIVED_CRP_PNTHSE_F() -> String { return "Lived in a corpo provided penthouse. "; }
    public static func LIVED_CRP_PNTHSE_M() -> String { return ""; }
    public static func LIVED_LXR_PNTHSE_F() -> String { return "Lived in a luxury penthouse. "; }
    public static func LIVED_LXR_PNTHSE_M() -> String { return ""; }
    public static func LIVED_MNSION_F() -> String { return "Lived in a mansion in Los Angeles. "; }
    public static func LIVED_MNSION_M() -> String { return ""; }
    public static func LIVED_RSRCH_FCLY_F() -> String { return "Lived in a classified research facility. "; }
    public static func LIVED_RSRCH_FCLY_M() -> String { return ""; }
    public static func LIVED_GTD_CRP_F() -> String { return "Lived in a gated %corp% Corporation compound. "; }
    public static func LIVED_GTD_CRP_M() -> String { return ""; }
    public static func LIVED_NORTH_OAK_F() -> String { return "Lived in North Oak. "; }
    public static func LIVED_NORTH_OAK_M() -> String { return ""; }
    public static func LIVED_WESTBROOK_F() -> String { return "Lived in a luxury Westbrook apartment. "; }
    public static func LIVED_WESTBROOK_M() -> String { return ""; }
    public static func LIVED_CORPO_PLAZA_F() -> String { return "Lived in City Center near Corpo Plaza. "; }
    public static func LIVED_CORPO_PLAZA_M() -> String { return ""; }
    public static func LIVED_ARASAKA_TWR_F() -> String { return "Lived in executive housing at Arasaka Tower. "; }
    public static func LIVED_ARASAKA_TWR_M() -> String { return ""; }
    public static func LIVED_KONPEKI_F() -> String { return "Lived at Konpeki Plaza. "; }
    public static func LIVED_KONPEKI_M() -> String { return ""; }

    // === INTERNATIONAL ===
    public static func LIVED_EUROPE_F() -> String { return "Lived in Europe. "; }
    public static func LIVED_EUROPE_M() -> String { return ""; }
    public static func LIVED_TOKYO_F() -> String { return "Lived in Tokyo. "; }
    public static func LIVED_TOKYO_M() -> String { return ""; }
    public static func LIVED_HONG_KONG_F() -> String { return "Lived in Hong Kong. "; }
    public static func LIVED_HONG_KONG_M() -> String { return ""; }
    public static func LIVED_BERLIN_F() -> String { return "Lived in Berlin. "; }
    public static func LIVED_BERLIN_M() -> String { return ""; }
    public static func LIVED_LONDON_F() -> String { return "Lived in London. "; }
    public static func LIVED_LONDON_M() -> String { return ""; }
    public static func LIVED_MEXICO_F() -> String { return "Lived in Mexico City. "; }
    public static func LIVED_MEXICO_M() -> String { return ""; }
    public static func LIVED_SAO_PAULO_F() -> String { return "Lived in São Paulo. "; }
    public static func LIVED_SAO_PAULO_M() -> String { return ""; }
    public static func LIVED_ATLANTA_F() -> String { return "Lived in Atlanta before moving to Night City. "; }
    public static func LIVED_ATLANTA_M() -> String { return ""; }
    public static func LIVED_LA_F() -> String { return "Lived in Los Angeles. "; }
    public static func LIVED_LA_M() -> String { return ""; }
    public static func LIVED_ORBITAL_F() -> String { return "Lived on an orbital station. "; }
    public static func LIVED_ORBITAL_M() -> String { return ""; }
    public static func LIVED_CRYSTAL_F() -> String { return "Lived on the Crystal Palace. "; }
    public static func LIVED_CRYSTAL_M() -> String { return ""; }

    // === PACIFICA ===
    public static func LIVED_PACIFICA_F() -> String { return "Lived in the ruins of Pacifica. "; }
    public static func LIVED_PACIFICA_M() -> String { return ""; }
    public static func LIVED_GIM_F() -> String { return "Squatted in the Grand Imperial Mall. "; }
    public static func LIVED_GIM_M() -> String { return ""; }
    public static func LIVED_COASTVIEW_F() -> String { return "Lived in Coastview, Pacifica. "; }
    public static func LIVED_COASTVIEW_M() -> String { return ""; }
    public static func LIVED_WEST_WIND_F() -> String { return "Lived in West Wind Estate. "; }
    public static func LIVED_WEST_WIND_M() -> String { return ""; }
    public static func LIVED_DOGTOWN_F() -> String { return "Lived in Dogtown. "; }
    public static func LIVED_DOGTOWN_M() -> String { return ""; }

}
