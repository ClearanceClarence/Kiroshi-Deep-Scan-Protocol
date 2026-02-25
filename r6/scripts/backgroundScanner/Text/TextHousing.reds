// Housing and living situations
public abstract class KdspTextHousing {
    // === HOMELESS / STREET ===
    public static func LIVED_ALLEY() -> String { return "Lived in an alley. "; }
    public static func LIVED_DMPSTR() -> String { return "Lived in a dumpster. "; }
    public static func LIVED_DRNPIPE() -> String { return "Lived in a drainpipe. "; }
    public static func LIVED_GUTTR() -> String { return "Lived in a gutter. "; }
    public static func LIVED_SEWER() -> String { return "Lived in a sewer. "; }
    public static func LIVED_ABN_CAR() -> String { return "Lived in an abandoned car. "; }
    public static func LIVED_VAN() -> String { return "Lived in a van. "; }
    public static func LIVED_BOX() -> String { return "Lived in a cardboard box. "; }
    public static func LIVED_TENT_FRWY() -> String { return "Lived in a tent under the freeway. "; }
    public static func LIVED_UDR_BRIDGE() -> String { return "Lived under a bridge. "; }
    public static func LIVED_RDS_CAR() -> String { return "Lived in a car on the roadside. "; }
    public static func LIVED_CONTAINER() -> String { return "Lived in a converted shipping container. "; }
    public static func LIVED_ROOFTOP() -> String { return "Lived in a makeshift shelter on a rooftop. "; }
    public static func LIVED_FACTORY() -> String { return "Squatted in an abandoned factory. "; }
    public static func LIVED_METRO() -> String { return "Lived in the abandoned metro tunnels. "; }
    public static func LIVED_CONSTR() -> String { return "Squatted in an unfinished construction site. "; }
    // === DANGEROUS / CRIME AREAS ===
    public static func LIVED_COMBAT_ZONE() -> String { return "Lived in the heart of the Combat Zone. "; }
    public static func LIVED_CHEM_DEN() -> String { return "Lived in a chem den. "; }
    public static func LIVED_CRM_HOOD() -> String { return "Lived in a crime-ridden neighborhood in Night City. "; }
    public static func LIVED_GNG_BANDIT() -> String { return "Lived among a gang of bandits. "; }
    public static func LIVED_MAELSTROM() -> String { return "Lived in Maelstrom-controlled territory. "; }
    public static func LIVED_TYGER() -> String { return "Lived in Tyger Claws territory. "; }
    public static func LIVED_VALENTINO() -> String { return "Lived in Valentinos territory. "; }

    public static func LIVED_ANIMALS() -> String { return "Lived in The Animals territory. "; }
    public static func LIVED_VDB() -> String { return "Lived in Voodoo Boys territory in Pacifica. "; }
    public static func LIVED_SCAV() -> String { return "Lived near a Scav operation. "; }
    // === LOW-INCOME / WORKING CLASS ===
    public static func LIVED_APT_MGTWR() -> String { return "Lived in an apartment in a megatower. "; }
    public static func LIVED_JNTR_MGTWR() -> String { return "Lived in a janitor's closet in a megatower. "; }
    public static func LIVED_MULTI_FAM() -> String { return "Lived in a multi-family home in Night City. "; }
    public static func LIVED_SHED_INDSTR() -> String { return "Lived in a shed in an industrial district. "; }
    public static func LIVED_SHANTY() -> String { return "Lived in a favela shanty in Night City. "; }
    public static func LIVED_CRAP_TWNHME() -> String { return "Lived in a crummy townhome apartment in Night City. "; }
    public static func LIVED_RANCHO_HOUSE() -> String { return "Lived in a run-down house in Rancho Coronado. "; }
    public static func LIVED_DECAY_HOOD() -> String { return "Lived in a decaying, once upscale neighborhood. "; }
    public static func LIVED_ABV_LAUND() -> String { return "Lived above a laundromat in Night City. "; }
    public static func LIVED_ABV_BAR() -> String { return "Lived above a bar in Night City. "; }
    public static func LIVED_MHOME_FRWY() -> String { return "Lived in a mobile home along the freeway. "; }
    public static func LIVED_COFFIN() -> String { return "Lived in a coffin hotel. "; }
    public static func LIVED_CUBE() -> String { return "Lived permanently in a cube hotel. "; }
    public static func LIVED_H4() -> String { return "Lived in Megabuilding H4 in Little China. "; }
    public static func LIVED_H10() -> String { return "Lived in Megabuilding H10 in Watson. "; }
    public static func LIVED_ARROYO() -> String { return "Lived in the Arroyo district. "; }
    public static func LIVED_KABUKI() -> String { return "Lived in Kabuki. "; }
    public static func LIVED_GLEN() -> String { return "Lived in The Glen. "; }
    public static func LIVED_JAPANTOWN() -> String { return "Lived in Japantown. "; }
    public static func LIVED_CHARTER() -> String { return "Lived in Charter Hill. "; }
    public static func LIVED_VISTA() -> String { return "Lived in Vista del Rey. "; }
    public static func LIVED_WELLSPRINGS() -> String { return "Lived in Wellsprings. "; }
    // === NOMAD / BADLANDS ===
    public static func LIVED_TENT_WASTES() -> String { return "Lived in a tent in the wastes. "; }
    public static func LIVED_NOMAD_PACK() -> String { return "Lived in a nomad pack moving from city to city. "; }
    public static func LIVED_SHACK() -> String { return "Lived in a tar-paper shack in the burning badlands far from the city. "; }
    // Expanded Housing - Nomad Living
    public static func LIVED_RV() -> String { return "Grew up in an RV in the badlands. "; }
    public static func LIVED_CONVOY() -> String { return "Grew up traveling with a nomad convoy. "; }
    public static func LIVED_MOBILE_BASE() -> String { return "Grew up in a mobile base. "; }
    public static func LIVED_BASILISK() -> String { return "Grew up in a converted Basilisk tank. "; }
    public static func LIVED_TRUCK_STOP() -> String { return "Grew up at a truck stop in the badlands. "; }
    public static func LIVED_REST_STOP() -> String { return "Grew up at a rest stop. "; }
    public static func LIVED_OILFIELD() -> String { return "Grew up near an oilfield camp. "; }
    public static func LIVED_SOLAR_FARM() -> String { return "Grew up near a solar farm. "; }
    public static func LIVED_WIND_FARM() -> String { return "Grew up near a wind farm. "; }
    public static func LIVED_BORDER_TOWN() -> String { return "Grew up in a border town. "; }
    // Expanded Housing - Underground
    public static func LIVED_BUNKER() -> String { return "Grew up in an underground bunker. "; }
    public static func LIVED_BASEMENT() -> String { return "Grew up in a basement apartment. "; }
    public static func LIVED_UTILITY() -> String { return "Grew up in utility tunnels. "; }
    public static func LIVED_PARKING() -> String { return "Grew up in an underground parking garage. "; }
    public static func LIVED_CATACOMB() -> String { return "Grew up in old catacombs beneath the city. "; }
    // Expanded Housing - Gang Territory
    public static func LIVED_GANG_TURF() -> String { return "Grew up on gang turf. "; }
    public static func LIVED_WAR_ZONE() -> String { return "Grew up in a gang war zone. "; }
    public static func LIVED_RED_ZONE() -> String { return "Grew up in a red zone combat area. "; }
    public static func LIVED_CHEM_ZONE() -> String { return "Grew up near a chemical contamination zone. "; }
    public static func LIVED_RADIATION() -> String { return "Grew up in a radiation-affected area. "; }
    public static func LIVED_SCAV_TERR() -> String { return "Grew up in Scav territory. "; }
    public static func LIVED_6TH_ST() -> String { return "Grew up in 6th Street territory. "; }
    public static func LIVED_VOODOO() -> String { return "Grew up in Voodoo Boys territory. "; }
    // Expanded Housing - Institutional
    public static func LIVED_HOSPITAL() -> String { return "Spent much of childhood in hospitals. "; }
    public static func LIVED_PSYCH_WARD() -> String { return "Grew up in a psychiatric facility. "; }
    public static func LIVED_REHAB() -> String { return "Spent time in juvenile rehabilitation. "; }
    public static func LIVED_JUVENILE() -> String { return "Grew up in juvenile detention. "; }
    public static func LIVED_PRISON() -> String { return "Spent formative years in prison. "; }
    public static func LIVED_HALFWAY() -> String { return "Lived in a halfway house. "; }
    public static func LIVED_MILITARY_BASE() -> String { return "Grew up on a military base. "; }
    public static func LIVED_BARRACKS() -> String { return "Grew up in military barracks. "; }
    // Expanded Housing - Unconventional
    public static func LIVED_BOAT() -> String { return "Grew up on a boat. "; }
    public static func LIVED_HOUSEBOAT() -> String { return "Grew up on a houseboat. "; }
    public static func LIVED_CONSTRUCTION() -> String { return "Grew up in an abandoned construction site. "; }
    public static func LIVED_WAREHOUSE() -> String { return "Grew up in an abandoned warehouse. "; }
    public static func LIVED_OFFICE() -> String { return "Grew up in an abandoned office building. "; }
    public static func LIVED_MALL() -> String { return "Grew up in an abandoned mall. "; }
    public static func LIVED_SCHOOL() -> String { return "Grew up squatting in an abandoned school. "; }
    public static func LIVED_CHURCH() -> String { return "Grew up in an abandoned church. "; }
    public static func LIVED_STADIUM() -> String { return "Grew up in an abandoned stadium. "; }
    public static func LIVED_AMUSEMENT() -> String { return "Grew up in an abandoned amusement park. "; }
    public static func LIVED_STORAGE() -> String { return "Grew up in a storage unit. "; }
    public static func LIVED_MOTEL() -> String { return "Grew up in a run-down motel. "; }
    public static func LIVED_NO_TELL() -> String { return "Grew up in a No-Tell Motel. "; }
    public static func LIVED_NOMAD_CAMP() -> String { return "Lived in a nomad camp outside the city. "; }
    public static func LIVED_ROCKY() -> String { return "Lived near Rocky Ridge in the badlands. "; }
    public static func LIVED_BIOTECH_FLATS() -> String { return "Lived near the Biotechnica Flats. "; }
    public static func LIVED_JACKSON() -> String { return "Lived in the Jackson Plains. "; }
    public static func LIVED_MOBILE() -> String { return "Lived a mobile life in convoy vehicles. "; }
    public static func LIVED_SMUGGLER() -> String { return "Lived at a smuggler's outpost in the badlands. "; }
    // === MIDDLE CLASS ===
    public static func LIVED_SMLL_TOWN() -> String { return "Lived in a small town far from the city. "; }
    public static func LIVED_NICE_TWNHME() -> String { return "Lived in a nice townhouse in Night City. "; }
    public static func LIVED_VILLAGE() -> String { return "Lived in a village far from the city. "; }
    public static func LIVED_LUDDITE() -> String { return "Moved into a luddite commune. "; }
    public static func LIVED_HEYWOOD() -> String { return "Lived in a decent apartment in Heywood. "; }
    public static func LIVED_SANTO() -> String { return "Lived in Santo Domingo. "; }
    public static func LIVED_GATED() -> String { return "Lived in a gated community outside Night City. "; }
    // === WEALTHY / CORPORATE ===
    public static func LIVED_LXR_MGTWR() -> String { return "Lived in a luxury megatower. "; }
    public static func LIVED_CRP_SBRB() -> String { return "Lived in a safe corpo suburbia. "; }
    public static func LIVED_CRP_ZONE() -> String { return "Lived in a defended corpo zone in Night City. "; }
    public static func LIVED_CRP_RSRCH() -> String { return "Lived in a corpo controlled research facility. "; }
    public static func LIVED_CRP_FARM() -> String { return "Lived on a corpo controlled farm. "; }
    public static func LIVED_CRP_PNTHSE() -> String { return "Lived in a corpo provided penthouse. "; }
    public static func LIVED_LXR_PNTHSE() -> String { return "Lived in a luxury penthouse. "; }
    public static func LIVED_MNSION() -> String { return "Lived in a mansion in Los Angeles. "; }
    public static func LIVED_RSRCH_FCLY() -> String { return "Lived in a classified research facility. "; }
    public static func LIVED_GTD_CRP() -> String { return "Lived in a gated %corp% Corporation compound. "; }
    public static func LIVED_NORTH_OAK() -> String { return "Lived in North Oak. "; }
    public static func LIVED_WESTBROOK() -> String { return "Lived in a luxury Westbrook apartment. "; }
    public static func LIVED_CORPO_PLAZA() -> String { return "Lived in City Center near Corpo Plaza. "; }
    public static func LIVED_ARASAKA_TWR() -> String { return "Lived in executive housing at Arasaka Tower. "; }
    public static func LIVED_KONPEKI() -> String { return "Lived at Konpeki Plaza. "; }
    // === INTERNATIONAL ===
    public static func LIVED_EUROPE() -> String { return "Lived in Europe. "; }
    public static func LIVED_TOKYO() -> String { return "Lived in Tokyo. "; }
    public static func LIVED_HONG_KONG() -> String { return "Lived in Hong Kong. "; }
    public static func LIVED_BERLIN() -> String { return "Lived in Berlin. "; }
    public static func LIVED_LONDON() -> String { return "Lived in London. "; }
    public static func LIVED_MEXICO() -> String { return "Lived in Mexico City. "; }
    public static func LIVED_SAO_PAULO() -> String { return "Lived in São Paulo. "; }
    public static func LIVED_ATLANTA() -> String { return "Lived in Atlanta before moving to Night City. "; }
    public static func LIVED_LA() -> String { return "Lived in Los Angeles. "; }
    public static func LIVED_ORBITAL() -> String { return "Lived on an orbital station. "; }
    public static func LIVED_CRYSTAL() -> String { return "Lived on the Crystal Palace. "; }
    // === PACIFICA ===
    public static func LIVED_PACIFICA() -> String { return "Lived in the ruins of Pacifica. "; }
    public static func LIVED_GIM() -> String { return "Squatted in the Grand Imperial Mall. "; }
    public static func LIVED_COASTVIEW() -> String { return "Lived in Coastview, Pacifica. "; }
    public static func LIVED_WEST_WIND() -> String { return "Lived in West Wind Estate. "; }
    public static func LIVED_DOGTOWN() -> String { return "Lived in Dogtown. "; }
    // === EXPANDED: SPECIFIC LOCATIONS ===
    public static func LIVED_NORTHSIDE() -> String { return "Lived in Northside, Watson. "; }
    public static func LIVED_VISTA_DEL_REY() -> String { return "Lived in Vista del Rey, Heywood. "; }
    public static func LIVED_RANCHO() -> String { return "Lived in Rancho Coronado. "; }
    public static func LIVED_LITTLE_CHINA() -> String { return "Lived in Little China, Watson. "; }
    // === EXPANDED: TEMPORARY / TRANSIENT ===
    public static func LIVED_SHELTER() -> String { return "Stayed in shelters for months. "; }
    public static func LIVED_STAIRWELL() -> String { return "Slept in megabuilding stairwells. "; }
    public static func LIVED_LAUNDROMAT() -> String { return "Slept in a 24-hour laundromat. "; }
    public static func LIVED_ARCADE() -> String { return "Crashed in the back of an arcade. "; }
    // === EXPANDED: UNUSUAL HOUSING ===
    public static func LIVED_CONVERTED_BUS() -> String { return "Lived in a converted bus. "; }
    public static func LIVED_COMM_TOWER() -> String { return "Squatted in an abandoned comm tower. "; }
    public static func LIVED_BILLBOARD() -> String { return "Made a shelter behind a massive billboard. "; }
    public static func LIVED_SERVER_ROOM() -> String { return "Lived in a decommissioned server room. "; }
    public static func LIVED_CRANE() -> String { return "Squatted in a construction crane cab. "; }
    // === EXPANDED: UPGRADES / MOVES ===
    public static func LIVED_FIRST_APT() -> String { return "Got %his% first apartment. One room, no windows. "; }
    public static func LIVED_PENTHOUSE() -> String { return "Briefly lived in a penthouse. "; }
    public static func LIVED_SHARED_APT() -> String { return "Shared an apartment with five others. "; }
    public static func LIVED_ABOVE_BAR() -> String { return "Lived above a bar. Never slept well. "; }
    public static func LIVED_BACK_SHOP() -> String { return "Lived in the back of a shop. "; }
    public static func LIVED_RIPPER_CLINIC() -> String { return "Lived above a ripperdoc clinic. "; }
}
