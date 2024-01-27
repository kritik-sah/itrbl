// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ContributorsOfITRebel is
    ERC721,
    ERC721Enumerable,
    ERC721Pausable,
    Ownable
{
    using Strings for uint256;

    event TokenURIUpdated(uint256 indexed tokenId, string uri);

    uint256 private _nextTokenId;

    uint256 public mintValue = 40 ether;
    uint256 public minEtherValue = 20 ether;
    string public version = "";
    bool public isMinting = true;

    enum ClassType {
        Wizard,
        Fairy,
        Dragon,
        Zombie,
        Supervillain,
        Superhero,
        Troll,
        Doctor,
        Cop,
        Firefighter,
        Vampire,
        Genie,
        Ninja,
        Elf
    }

    enum Attack {
        Empty,
        Thunderbolt,
        MagicMissile,
        TeleportationStrike,
        CycloneOfChaos,
        PrismBeam,
        VolcanicEruption,
        AstralProjection,
        PixieDustBlast,
        EnchantedVineWhirlwind,
        StarlightBeam,
        MushroomSporeExplosion,
        RainbowBurst,
        BlossomPetalStorm,
        FireBreath,
        FrostNova,
        TornadoTailSwipe,
        LightningRoar,
        MoltenMeteorShower,
        PrismaticScaleRadiance,
        RottenGrasp,
        SkullCrush,
        LurchingMenace,
        BloodSpatterHurl,
        HorrifyingShuffle,
        SleepersCurse,
        ExplosiveHavoc,
        DeathRayBlast,
        ChaosWhirlwind,
        DemolitionSlam,
        VillainousGrasp,
        ShadowyScheme,
        SuperStrengthSlam,
        FlyingFistSmash,
        TelekineticWave,
        JusticePunch,
        SonicScream,
        EnergyShieldBash,
        TreeTrunkSmash,
        UglyMugSlam,
        OgreStrengthStrike,
        BoulderPunch,
        ClubWhirlwind,
        LeafyBarricade,
        SyringeInjection,
        HealingPulse,
        LabExperimentExplosion,
        LifeResuscitation,
        TemperatureSurge,
        ImmunityShield,
        SirenStun,
        JusticeBatonStrike,
        HandcuffBind,
        PatrolCarRam,
        LawEnforcementSlam,
        SurveillanceScan,
        FireExtinguisherBlast,
        RescueLadderSwing,
        WaterHoseTorrent,
        InfernoQuencher,
        FirstAidBlazeFix,
        AnchorSplash,
        BatSwarmAssault,
        BloodsuckersEmbrace,
        NightshadeShadows,
        MoonlightDrain,
        CursedBite,
        BoneShatter,
        MagicLampBeam,
        WishfulWhirlwind,
        SandstormBlast,
        CosmicGrant,
        EnchantedMirage,
        ShurikenBarrage,
        ShadowStealthStrike,
        SmokeBombEvasion,
        SilentBladeSlash,
        SwiftMartialArtsCombo,
        NaturesWrath,
        ElvenArrowBarrage,
        StarlightEmissary,
        ForestGuardianShield,
        BlossomDance,
        PetalWhirlwind
    }

    // Mapping defs to store values
    // Use enums for class and attacks
    mapping(ClassType => string) internal className;
    mapping(Attack => string) internal attackName;

    mapping(ClassType => string) internal classEmojis;
    mapping(Attack => string) internal attackEmojis;

    mapping(ClassType => Attack[]) internal classAttacks;

    mapping(uint256 => TokenValue) public tokenValues;

    ClassType[] internal classList = [
        ClassType.Wizard,
        ClassType.Fairy,
        ClassType.Dragon,
        ClassType.Zombie,
        ClassType.Supervillain,
        ClassType.Superhero,
        ClassType.Troll,
        ClassType.Doctor,
        ClassType.Cop,
        ClassType.Firefighter,
        ClassType.Vampire,
        ClassType.Genie,
        ClassType.Ninja,
        ClassType.Elf
    ];

    function classNameMapping() internal {
        className[ClassType.Wizard] = "wizard";
        className[ClassType.Fairy] = "fairy";
        className[ClassType.Dragon] = "dragon";
        className[ClassType.Zombie] = "zombie";
        className[ClassType.Supervillain] = "supervillain";
        className[ClassType.Superhero] = "superhero";
        className[ClassType.Troll] = "troll";
        className[ClassType.Doctor] = "doctor";
        className[ClassType.Cop] = "cop";
        className[ClassType.Firefighter] = "firefighter";
        className[ClassType.Vampire] = "vampire";
        className[ClassType.Genie] = "genie";
        className[ClassType.Ninja] = "ninja";
        className[ClassType.Elf] = "elf";
    }

    function attackNameMapping() internal {
        attackName[Attack.Empty] = "Empty";
        attackName[Attack.Thunderbolt] = "Thunderbolt";
        attackName[Attack.MagicMissile] = "Magic Missile";
        attackName[Attack.TeleportationStrike] = "Teleportation Strike";
        attackName[Attack.CycloneOfChaos] = "Cyclone Of Chaos";
        attackName[Attack.PrismBeam] = "Prism Beam";
        attackName[Attack.VolcanicEruption] = "Volcanic Eruption";
        attackName[Attack.AstralProjection] = "Astral Projection";
        attackName[Attack.PixieDustBlast] = "Pixie Dust Blast";
        attackName[Attack.EnchantedVineWhirlwind] = "Enchanted Vine Whirlwind";
        attackName[Attack.StarlightBeam] = "Starlight Beam";
        attackName[Attack.MushroomSporeExplosion] = "Mushroom Spore Explosion";
        attackName[Attack.RainbowBurst] = "Rainbow Burst";
        attackName[Attack.BlossomPetalStorm] = "Blossom Petal Storm";
        attackName[Attack.FireBreath] = "Fire Breath";
        attackName[Attack.FrostNova] = "Frost Nova";
        attackName[Attack.TornadoTailSwipe] = "Tornado Tail Swipe";
        attackName[Attack.LightningRoar] = "Lightning Roar";
        attackName[Attack.MoltenMeteorShower] = "Molten Meteor Shower";
        attackName[Attack.PrismaticScaleRadiance] = "Prismatic Scale Radiance";
        attackName[Attack.RottenGrasp] = "Rotten Grasp";
        attackName[Attack.SkullCrush] = "Skull Crush";
        attackName[Attack.LurchingMenace] = "Lurching Menace";
        attackName[Attack.BloodSpatterHurl] = "Blood Spatter Hurl";
        attackName[Attack.HorrifyingShuffle] = "Horrifying Shuffle";
        attackName[Attack.SleepersCurse] = "Sleepers Curse";
        attackName[Attack.ExplosiveHavoc] = "Explosive Havoc";
        attackName[Attack.DeathRayBlast] = "Death Ray Blast";
        attackName[Attack.ChaosWhirlwind] = "Chaos Whirlwind";
        attackName[Attack.DemolitionSlam] = "Demolition Slam";
        attackName[Attack.VillainousGrasp] = "Villainous Grasp";
        attackName[Attack.ShadowyScheme] = "Shadowy Scheme";
        attackName[Attack.SuperStrengthSlam] = "Super Strength Slam";
        attackName[Attack.FlyingFistSmash] = "Flying Fist Smash";
        attackName[Attack.TelekineticWave] = "Telekinetic Wave";
        attackName[Attack.JusticePunch] = "Justice Punch";
        attackName[Attack.SonicScream] = "Sonic Scream";
        attackName[Attack.EnergyShieldBash] = "Energy Shield Bash";
        attackName[Attack.TreeTrunkSmash] = "Tree Trunk Smash";
        attackName[Attack.UglyMugSlam] = "Ugly Mug Slam";
        attackName[Attack.OgreStrengthStrike] = "Ogre Strength Strike";
        attackName[Attack.BoulderPunch] = "Boulder Punch";
        attackName[Attack.ClubWhirlwind] = "Club Whirlwind";
        attackName[Attack.LeafyBarricade] = "Leafy Barricade";
        attackName[Attack.SyringeInjection] = "Syringe Injection";
        attackName[Attack.HealingPulse] = "Healing Pulse";
        attackName[Attack.LabExperimentExplosion] = "Lab Experiment Explosion";
        attackName[Attack.LifeResuscitation] = "Life Resuscitation";
        attackName[Attack.TemperatureSurge] = "Temperature Surge";
        attackName[Attack.ImmunityShield] = "Immunity Shield";
        attackName[Attack.SirenStun] = "Siren Stun";
        attackName[Attack.JusticeBatonStrike] = "Justice Baton Strike";
        attackName[Attack.HandcuffBind] = "Handcuff Bind";
        attackName[Attack.PatrolCarRam] = "Patrol Car Ram";
        attackName[Attack.LawEnforcementSlam] = "Law Enforcement Slam";
        attackName[Attack.SurveillanceScan] = "Surveillance Scan";
        attackName[Attack.FireExtinguisherBlast] = "Fire Extinguisher Blast";
        attackName[Attack.RescueLadderSwing] = "Rescue Ladder Swing";
        attackName[Attack.WaterHoseTorrent] = "Water Hose Torrent";
        attackName[Attack.InfernoQuencher] = "Inferno Quencher";
        attackName[Attack.FirstAidBlazeFix] = "First Aid Blaze Fix";
        attackName[Attack.AnchorSplash] = "Anchor Splash";
        attackName[Attack.BatSwarmAssault] = "Bat Swarm Assault";
        attackName[Attack.BloodsuckersEmbrace] = "Bloodsuckers Embrace";
        attackName[Attack.NightshadeShadows] = "Nightshade Shadows";
        attackName[Attack.MoonlightDrain] = "Moonlight Drain";
        attackName[Attack.CursedBite] = "Cursed Bite";
        attackName[Attack.BoneShatter] = "Bone Shatter";
        attackName[Attack.MagicLampBeam] = "Magic Lamp Beam";
        attackName[Attack.WishfulWhirlwind] = "Wishful Whirlwind";
        attackName[Attack.SandstormBlast] = "Sandstorm Blast";
        attackName[Attack.CosmicGrant] = "Cosmic Grant";
        attackName[Attack.EnchantedMirage] = "Enchanted Mirage";
        attackName[Attack.ShurikenBarrage] = "Shuriken Barrage";
        attackName[Attack.ShadowStealthStrike] = "Shadow Stealth Strike";
        attackName[Attack.SmokeBombEvasion] = "Smoke Bomb Evasion";
        attackName[Attack.SilentBladeSlash] = "Silent Blade Slash";
        attackName[Attack.SwiftMartialArtsCombo] = "Swift Martial Arts Combo";
        attackName[Attack.NaturesWrath] = "Nature's Wrath";
        attackName[Attack.ElvenArrowBarrage] = "Elven Arrow Barrage";
        attackName[Attack.StarlightEmissary] = "Starlight Emissary";
        attackName[Attack.ForestGuardianShield] = "Forest Guardian Shield";
        attackName[Attack.BlossomDance] = "Blossom Dance";
        attackName[Attack.PetalWhirlwind] = "Petal Whirlwind";
    }

    function classEmojiMapping() internal {
        classEmojis[ClassType.Wizard] = unicode"🧙";
        classEmojis[ClassType.Fairy] = unicode"🧚";
        classEmojis[ClassType.Dragon] = unicode"🐉";
        classEmojis[ClassType.Zombie] = unicode"🧟";
        classEmojis[ClassType.Supervillain] = unicode"🦹";
        classEmojis[ClassType.Superhero] = unicode"🦸";
        classEmojis[ClassType.Troll] = unicode"👹";
        classEmojis[ClassType.Doctor] = unicode"👨‍⚕️";
        classEmojis[ClassType.Cop] = unicode"👮";
        classEmojis[ClassType.Firefighter] = unicode"👨‍🚒";
        classEmojis[ClassType.Vampire] = unicode"🧛";
        classEmojis[ClassType.Genie] = unicode"🧞";
        classEmojis[ClassType.Ninja] = unicode"🥷";
        classEmojis[ClassType.Elf] = unicode"🧝";
    }

    function attackEmojiMapping() internal {
        attackEmojis[Attack.Empty] = unicode"❓";
        attackEmojis[Attack.Thunderbolt] = unicode"⚡";
        attackEmojis[Attack.MagicMissile] = unicode"🔮";
        attackEmojis[Attack.TeleportationStrike] = unicode"🌐";
        attackEmojis[Attack.CycloneOfChaos] = unicode"🌀";
        attackEmojis[Attack.PrismBeam] = unicode"🌈";
        attackEmojis[Attack.VolcanicEruption] = unicode"🌋";
        attackEmojis[Attack.AstralProjection] = unicode"🌌";

        attackEmojis[Attack.PixieDustBlast] = unicode"✨";
        attackEmojis[Attack.EnchantedVineWhirlwind] = unicode"🌿";
        attackEmojis[Attack.StarlightBeam] = unicode"🌟";
        attackEmojis[Attack.MushroomSporeExplosion] = unicode"🍄";
        attackEmojis[Attack.RainbowBurst] = unicode"🌈";
        attackEmojis[Attack.BlossomPetalStorm] = unicode"🌸";

        attackEmojis[Attack.FireBreath] = unicode"🔥";
        attackEmojis[Attack.FrostNova] = unicode"❄️";
        attackEmojis[Attack.TornadoTailSwipe] = unicode"🌪️";
        attackEmojis[Attack.LightningRoar] = unicode"⚡";
        attackEmojis[Attack.MoltenMeteorShower] = unicode"🌠";
        attackEmojis[Attack.PrismaticScaleRadiance] = unicode"🌈";

        attackEmojis[Attack.LurchingMenace] = unicode"🚶‍♂️";
        attackEmojis[Attack.BloodSpatterHurl] = unicode"🩸";
        attackEmojis[Attack.HorrifyingShuffle] = unicode"👻";
        attackEmojis[Attack.SleepersCurse] = unicode"💤";

        attackEmojis[Attack.ExplosiveHavoc] = unicode"💥";
        attackEmojis[Attack.DeathRayBlast] = unicode"☠️";
        attackEmojis[Attack.ChaosWhirlwind] = unicode"🌀";
        attackEmojis[Attack.DemolitionSlam] = unicode"🚧";

        attackEmojis[Attack.VillainousGrasp] = unicode"🦹‍♂️";
        attackEmojis[Attack.ShadowyScheme] = unicode"🌑";
        attackEmojis[Attack.TreeTrunkSmash] = unicode"🌳";
        attackEmojis[Attack.UglyMugSlam] = unicode"💥";
        attackEmojis[Attack.OgreStrengthStrike] = unicode"👹";
        attackEmojis[Attack.BoulderPunch] = unicode"👊";
        attackEmojis[Attack.ClubWhirlwind] = unicode"🌪️";
        attackEmojis[Attack.LeafyBarricade] = unicode"🍃";

        attackEmojis[Attack.SyringeInjection] = unicode"💉";
        attackEmojis[Attack.HealingPulse] = unicode"💓";

        attackEmojis[Attack.LabExperimentExplosion] = unicode"🧪";
        attackEmojis[Attack.LifeResuscitation] = unicode"🔄";
        attackEmojis[Attack.TemperatureSurge] = unicode"🌡️";
        attackEmojis[Attack.ImmunityShield] = unicode"🛡️";
        attackEmojis[Attack.SirenStun] = unicode"🚨";
        attackEmojis[Attack.JusticeBatonStrike] = unicode"👮";
        attackEmojis[Attack.HandcuffBind] = unicode"🔗";
        attackEmojis[Attack.PatrolCarRam] = unicode"🚓";
        attackEmojis[Attack.LawEnforcementSlam] = unicode"⚖️";
        attackEmojis[Attack.SurveillanceScan] = unicode"🔍";
        attackEmojis[Attack.FireExtinguisherBlast] = unicode"🧯";
        attackEmojis[Attack.RescueLadderSwing] = unicode"🪜";
        attackEmojis[Attack.WaterHoseTorrent] = unicode"💦";
        attackEmojis[Attack.InfernoQuencher] = unicode"🧯";
        attackEmojis[Attack.FirstAidBlazeFix] = unicode"🩹";
        attackEmojis[Attack.AnchorSplash] = unicode"⚓";

        attackEmojis[Attack.BatSwarmAssault] = unicode"🦇";
        attackEmojis[Attack.BloodsuckersEmbrace] = unicode"🩸";
        attackEmojis[Attack.NightshadeShadows] = unicode"🌒";
        attackEmojis[Attack.MoonlightDrain] = unicode"🌕";
        attackEmojis[Attack.CursedBite] = unicode"🦷";
        attackEmojis[Attack.BoneShatter] = unicode"💀";
        attackEmojis[Attack.MagicLampBeam] = unicode"🔮";
        attackEmojis[Attack.WishfulWhirlwind] = unicode"🌪️";
        attackEmojis[Attack.SandstormBlast] = unicode"🏜️";
        attackEmojis[Attack.CosmicGrant] = unicode"🌌";
        attackEmojis[Attack.EnchantedMirage] = unicode"✨";

        attackEmojis[Attack.ShurikenBarrage] = unicode"🌀";
        attackEmojis[Attack.ShadowStealthStrike] = unicode"👥";
        attackEmojis[Attack.SmokeBombEvasion] = unicode"💨";
        attackEmojis[Attack.SilentBladeSlash] = unicode"🗡️";
        attackEmojis[Attack.SwiftMartialArtsCombo] = unicode"🥋";

        // Elf Attacks
        attackEmojis[Attack.NaturesWrath] = unicode"🍃";
        attackEmojis[Attack.ElvenArrowBarrage] = unicode"🏹";
        attackEmojis[Attack.StarlightEmissary] = unicode"✨";
        attackEmojis[Attack.ForestGuardianShield] = unicode"🛡️";
        attackEmojis[Attack.BlossomDance] = unicode"💃";
        attackEmojis[Attack.PetalWhirlwind] = unicode"🌸";

        attackEmojis[Attack.SuperStrengthSlam] = unicode"💪";
        attackEmojis[Attack.FlyingFistSmash] = unicode"👊";
        attackEmojis[Attack.TelekineticWave] = unicode"🌀";
        attackEmojis[Attack.JusticePunch] = unicode"⚖️";
        attackEmojis[Attack.SonicScream] = unicode"🗣️";
        attackEmojis[Attack.EnergyShieldBash] = unicode"🛡️";
    }

    function attacksByClassMapping() internal {
        classAttacks[ClassType.Wizard] = [
            Attack.Thunderbolt,
            Attack.MagicMissile,
            Attack.TeleportationStrike,
            Attack.CycloneOfChaos,
            Attack.PrismBeam,
            Attack.VolcanicEruption,
            Attack.AstralProjection
        ];
        classAttacks[ClassType.Fairy] = [
            Attack.PixieDustBlast,
            Attack.EnchantedVineWhirlwind,
            Attack.StarlightBeam,
            Attack.MushroomSporeExplosion,
            Attack.RainbowBurst,
            Attack.BlossomPetalStorm
        ];
        classAttacks[ClassType.Dragon] = [
            Attack.FireBreath,
            Attack.FrostNova,
            Attack.TornadoTailSwipe,
            Attack.LightningRoar,
            Attack.MoltenMeteorShower,
            Attack.PrismaticScaleRadiance
        ];
        classAttacks[ClassType.Zombie] = [
            Attack.RottenGrasp,
            Attack.SkullCrush,
            Attack.LurchingMenace,
            Attack.BloodSpatterHurl,
            Attack.HorrifyingShuffle,
            Attack.SleepersCurse
        ];
        classAttacks[ClassType.Supervillain] = [
            Attack.ExplosiveHavoc,
            Attack.DeathRayBlast,
            Attack.ChaosWhirlwind,
            Attack.DemolitionSlam,
            Attack.VillainousGrasp,
            Attack.ShadowyScheme
        ];
        classAttacks[ClassType.Superhero] = [
            Attack.SuperStrengthSlam,
            Attack.FlyingFistSmash,
            Attack.TelekineticWave,
            Attack.JusticePunch,
            Attack.SonicScream,
            Attack.EnergyShieldBash
        ];
        classAttacks[ClassType.Troll] = [
            Attack.TreeTrunkSmash,
            Attack.UglyMugSlam,
            Attack.OgreStrengthStrike,
            Attack.BoulderPunch,
            Attack.ClubWhirlwind,
            Attack.LeafyBarricade
        ];
        classAttacks[ClassType.Doctor] = [
            Attack.SyringeInjection,
            Attack.HealingPulse,
            Attack.LabExperimentExplosion,
            Attack.LifeResuscitation,
            Attack.TemperatureSurge,
            Attack.ImmunityShield
        ];
        classAttacks[ClassType.Cop] = [
            Attack.SirenStun,
            Attack.JusticeBatonStrike,
            Attack.HandcuffBind,
            Attack.PatrolCarRam,
            Attack.LawEnforcementSlam,
            Attack.SurveillanceScan
        ];
        classAttacks[ClassType.Firefighter] = [
            Attack.FireExtinguisherBlast,
            Attack.RescueLadderSwing,
            Attack.WaterHoseTorrent,
            Attack.InfernoQuencher,
            Attack.FirstAidBlazeFix,
            Attack.AnchorSplash
        ];
        classAttacks[ClassType.Vampire] = [
            Attack.BatSwarmAssault,
            Attack.BloodsuckersEmbrace,
            Attack.NightshadeShadows,
            Attack.MoonlightDrain,
            Attack.CursedBite,
            Attack.BoneShatter
        ];
        classAttacks[ClassType.Genie] = [
            Attack.MagicLampBeam,
            Attack.WishfulWhirlwind,
            Attack.SandstormBlast,
            Attack.CosmicGrant,
            Attack.EnchantedMirage
        ];
        classAttacks[ClassType.Ninja] = [
            Attack.ShurikenBarrage,
            Attack.ShadowStealthStrike,
            Attack.SmokeBombEvasion,
            Attack.SilentBladeSlash,
            Attack.SwiftMartialArtsCombo
        ];
        classAttacks[ClassType.Elf] = [
            Attack.NaturesWrath,
            Attack.ElvenArrowBarrage,
            Attack.StarlightEmissary,
            Attack.ForestGuardianShield,
            Attack.BlossomDance,
            Attack.PetalWhirlwind
        ];
    }

    constructor()
        ERC721("Contributors of IT Rebel", "ITRBL")
        Ownable(msg.sender)
    {
        classNameMapping();
        classEmojiMapping();
        attackNameMapping();
        attackEmojiMapping();
        attacksByClassMapping();
    }

    function updateMintValue(uint256 newMintValue) public onlyOwner {
        require(newMintValue > 0, "New mint value must be greater than 0");
        mintValue = newMintValue;
    }

    function updateisMintingValue(bool _isMintable) public onlyOwner {
        isMinting = _isMintable;
    }

    function updateMinEtherValue(uint256 newMinValue) public onlyOwner {
        require(newMinValue > 0, "New minimum value must be greater than 0");
        minEtherValue = newMinValue;
    }

    function updateVersion(string memory _version) public onlyOwner {
        version = _version;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    string[] internal lightPaints = [
        "#16FF00",
        "#FFFFD0",
        "#F7EC09",
        "#F90716",
        "#49FF00",
        "#FB8B24",
        "#5F0F40",
        "#F4BF96",
        "#D6D46D",
        "#606C5D",
        "#FF8400",
        "#E1F0DA",
        "#D4E7C5",
        "#DCFFB7",
        "#FFBB64",
        "#FFC5C5",
        "#DED0B6",
        "#C3ACD0",
        "#F9B572",
        "#D0BFFF",
        "#FFE5E5",
        "#FB8B24",
        "#5F0F40",
        "#F4BF96",
        "#D6D46D",
        "#606C5D",
        "#FF8400",
        "#E1F0DA",
        "#D4E7C5",
        "#DCFFB7",
        "#FFBB64",
        "#FFC5C5",
        "#DED0B6",
        "#C3ACD0",
        "#F9B572",
        "#D0BFFF",
        "#FFE5E5",
        "#9ED2BE",
        "#C8E4B2",
        "#FFF0F5",
        "#78C1F3",
        "#9BABB8",
        "#FFA559"
    ];

    string[] internal darkPaints = [
        "#3C0753",
        "#3E3232",
        "#2D3250",
        "#424769",
        "#092635",
        "#22092C",
        "#3E3232",
        "#2D3250",
        "#424769",
        "#092635",
        "#1B4242",
        "#191919",
        "#750E21",
        "#22092C",
        "#872341",
        "#610C9F",
        "#940B92",
        "#0F0F0F",
        "#451952",
        "#662549",
        "#040D12",
        "#030637",
        "#092635",
        "#1B4242",
        "#191919",
        "#750E21",
        "#872341",
        "#610C9F",
        "#940B92",
        "#0F0F0F",
        "#232D3F",
        "#451952",
        "#662549",
        "#040D12",
        "#232D3F",
        "#183D3D",
        "#352F44",
        "#5C5470",
        "#FF0000",
        "#363062"
    ];

    string[] internal SVG = [
        '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="120" fill="none"><path fill="#fff" d="M0 0h100v120H0z"/><path fill="url(#a)" fill-opacity=".49" d="M0 0h100v120H0z"/><path fill="url(#a)" fill-opacity=".2" stroke="url(#b)" stroke-width=".5" d="m86.013 67.91-.062-.16H14.05l-.063.16c-1.34 3.437-3.89 6.138-7.09 7.6l-.147.067v31.846l.146.067c3.202 1.462 5.75 4.163 7.091 7.601l.062.159H85.95l.063-.159c1.34-3.438 3.89-6.139 7.09-7.601l.147-.067V75.578l-.146-.068c-3.202-1.462-5.75-4.163-7.091-7.6Z"/><g filter="url(#c)"><circle cx="50.262" cy="35.262" r="26.262" fill="url(#b)"/></g><mask id="d" width="53" height="53" x="24" y="9" maskUnits="userSpaceOnUse" style="mask-type:alpha"><circle cx="50.262" cy="35.262" r="26.262" fill="url(#b)"/></mask><g mask="url(#d)"><path fill="#fff" fill-opacity=".2" d="m56.633 91.525-6.051-55.55L85.059 86.25l10.76-4.354-44.923-46.003 65.758 31.481 6.222-7.55-71.78-24.09 79.429 4.234V31.26l-79.372 4.235 71.837-24.13-6.222-7.53-65.73 31.44L96.02-10.747l-10.76-4.355L50.81 35.135l6.051-55.61H44.417l6.05 55.57L16.02-15.182 5.231-10.827l44.923 45.982-65.758-31.46-6.222 7.53 71.78 24.11-79.43-4.235v8.71l79.373-4.235-71.837 24.11 6.222 7.55 65.73-31.46L5.03 81.817l10.76 4.355 34.448-50.238-6.05 55.59h12.444Z"><animateTransform attributeName="transform" attributeType="XML" dur="10s" from="0" repeatCount="indefinite" to="50" type="rotate"/></path><g filter="url(#e)"><circle cx="50.262" cy="35.263" r="25.121" fill="url(#a)" fill-opacity=".96"/></g><g filter="url(#f)"><path fill="url(#b)" d="M48.449 47.005c0 1.073-.215 1.963-.644 2.668a5.357 5.357 0 0 1-1.61 1.702 7.112 7.112 0 0 1-2.162.874 9.459 9.459 0 0 1-2.208.276V25.799c0-2.147.49-3.803 1.472-4.968.981-1.165 2.392-1.748 4.232-1.748.92 0 1.671.153 2.254.46.583.307 1.027.705 1.334 1.196.337.49.567 1.027.69 1.61a7.41 7.41 0 0 1 .184 1.61c0 .276-.03.475-.092.598a2.136 2.136 0 0 0-1.426-.506c-.46 0-.828.092-1.104.276a1.733 1.733 0 0 0-.598.644 3.252 3.252 0 0 0-.276.874c-.03.337-.046.69-.046 1.058v20.102Zm4.048-27.83h.598c1.748 0 3.19.552 4.324 1.656 1.135 1.073 1.702 2.637 1.702 4.692v4.83c0 2.024-.506 3.557-1.518 4.6-.981 1.043-2.177 1.595-3.588 1.656h-.322c-.859 0-1.58-.153-2.162-.46a4.446 4.446 0 0 1-1.426-1.15 5.207 5.207 0 0 1-.736-1.564 6.677 6.677 0 0 1-.23-1.702c.215.184.414.322.598.414.184.061.552.092 1.104.092.399 0 .705-.107.92-.322.245-.245.414-.537.506-.874.123-.337.184-.705.184-1.104.03-.43.046-.813.046-1.15v-9.614Zm5.888 33.35h-.46c-.797 0-1.595-.077-2.392-.23a6.35 6.35 0 0 1-2.116-.828c-.613-.399-1.12-.95-1.518-1.656-.399-.705-.598-1.625-.598-2.76v-9.752h.736c.767 0 1.533.092 2.3.276a5.024 5.024 0 0 1 2.024.874c.613.399 1.104.95 1.472 1.656.368.705.552 1.61.552 2.714v9.706Z"/></g></g><text x="50%" y="101" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="4" font-weight="bold" text-anchor="middle">LEVEL</text><text x="50%" y="108" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="8" font-weight="bold" text-anchor="middle">',
        '</text><text x="50%" y="73" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="2.7" font-weight="900" text-anchor="middle">',
        '</text><text x="29%" y="81" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="5" font-weight="900" text-anchor="middle">CLASS</text><text x="29%" y="88" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="5" font-weight="900" text-anchor="middle">',
        '</text><text x="71%" y="81" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="5" font-weight="900" text-anchor="middle">ATTACK</text><text x="71%" y="88" fill="url(#b)" dominant-baseline="middle" font-family="inherit" font-size="5" font-weight="900" text-anchor="middle">',
        '</text><defs><filter id="c" width="60.525" height="60.525" x="20" y="6" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" result="hardAlpha" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/><feOffset dy="1"/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend in2="BackgroundImageFix" result="effect1_dropShadow_26_96"/><feBlend in="SourceGraphic" in2="effect1_dropShadow_26_96" result="shape"/></filter><filter id="e" width="52.241" height="53.241" x="24.142" y="9.142" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feBlend in="SourceGraphic" in2="BackgroundImageFix" result="shape"/><feColorMatrix in="SourceAlpha" result="hardAlpha" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/><feOffset dy="2"/><feGaussianBlur stdDeviation="2.5"/><feComposite in2="hardAlpha" k2="-1" k3="1" operator="arithmetic"/><feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/><feBlend in2="shape" result="effect1_innerShadow_26_96"/><feGaussianBlur result="effect2_foregroundBlur_26_96" stdDeviation=".5"/></filter><filter id="f" width="23.296" height="39.442" x="38.825" y="17.083" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" result="hardAlpha" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/><feOffset dy="1"/><feGaussianBlur stdDeviation="1.5"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/><feBlend in2="BackgroundImageFix" result="effect1_dropShadow_26_96"/><feBlend in="SourceGraphic" in2="effect1_dropShadow_26_96" result="shape"/></filter><linearGradient id="a" x1="0%" x2="100%" y1="0%" y2="0%"><stop offset="100%" style="stop-color:',
        ';stop-opacity:1"/></linearGradient><linearGradient id="b" x1="0%" x2="100%" y1="0%" y2="0%"><stop offset="100%" style="stop-color:',
        ';stop-opacity:1"/></linearGradient></defs></svg>'
    ];

    function generateSvg(
        uint256 level,
        string memory tokenName,
        string memory colorPrimary,
        string memory colorSecondary,
        ClassType class,
        Attack attackPrimary,
        Attack attackSecondary,
        Attack attackTertiary
    ) internal view returns (string memory) {
        string memory part1 = string(
            abi.encodePacked(SVG[0], Strings.toString(level), SVG[1], tokenName)
        );
        string memory attacks = string(
            abi.encodePacked(
                getAttackEmoji(attackPrimary),
                getAttackEmoji(attackSecondary),
                getAttackEmoji(attackTertiary)
            )
        );
        string memory part2 = string(
            abi.encodePacked(colorPrimary, SVG[5], colorSecondary, SVG[6])
        );

        string memory svg = string(
            abi.encodePacked(
                part1,
                SVG[2],
                getClassEmoji(class),
                SVG[3],
                attacks,
                SVG[4],
                part2
            )
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(bytes(svg))
                )
            );
    }

    function getClassEmoji(
        ClassType _classType
    ) internal view returns (string memory) {
        string memory emoji = classEmojis[_classType];
        return emoji;
    }

    function getAttackEmoji(
        Attack _attack
    ) internal view returns (string memory) {
        string memory emoji = attackEmojis[_attack];
        return emoji;
    }

    struct TokenValue {
        string name;
        string description;
        string colorPrimary;
        string colorSecondary;
        uint256 level;
        ClassType class;
        Attack attackPrimary;
        Attack attackSecondary;
        Attack attackTertiary;
    }

    function generateClass() internal view returns (ClassType) {
        uint256 randomIndex = randomNum(
            classList.length,
            block.timestamp,
            block.difficulty
        );
        return classList[randomIndex];
    }

    function generateAttacks(
        ClassType _classType
    ) internal view returns (Attack) {
        uint256 rand = randomNum(
            classAttacks[_classType].length,
            block.timestamp,
            block.difficulty
        );
        return classAttacks[_classType][rand];
    }

    function safeMint(address to) public payable {
        require(isMinting, "minting closed");
        if (msg.sender != owner()) {
            require(msg.value >= mintValue, "insufficient Ether value");
        }

        uint256 tokenId = _nextTokenId++;
        ClassType class = generateClass();
        Attack primaryAttack = generateAttacks(class);

        TokenValue memory newToken = TokenValue(
            string(
                abi.encodePacked(
                    "REBEL",
                    version,
                    " #",
                    uint256(tokenId).toString()
                )
            ),
            "Thanks for contributing to IT Rebels",
            lightPaints[
                randomNum(lightPaints.length, block.timestamp, tokenId)
            ],
            darkPaints[randomNum(darkPaints.length, block.timestamp, tokenId)],
            1,
            class,
            primaryAttack,
            Attack.Empty,
            Attack.Empty
        );

        // Mint the new token
        _safeMint(to, tokenId);

        // Update the mapping with the new token information
        tokenValues[tokenId] = newToken;

        // Emit an event to set the token URI dynamically
        emit TokenURIUpdated(tokenId, getTokenURI(tokenId));
    }

    function randomNum(
        uint256 _mod,
        uint256 _seed,
        uint _salt
    ) internal view returns (uint256) {
        uint256 num = uint(
            keccak256(
                abi.encodePacked(block.timestamp, msg.sender, _seed, _salt)
            )
        ) % _mod;
        return num;
    }

    function levelUp(uint256 tokenId) public payable {
        require(ownerOf(tokenId) == msg.sender, "only owner");
        require(msg.value >= minEtherValue, "insufficient Ether value");

        // Calculate the number of levels to increase based on the amount of Ether sent
        uint256 levelIncrease = msg.value / minEtherValue;

        // Update the level directly
        uint256 newLevel = tokenValues[tokenId].level + levelIncrease;

        // Update the struct directly
        tokenValues[tokenId].level = newLevel;

        checkLevelsAndTokenValue(tokenId);

        // Emit an event to set the token URI dynamically
        emit TokenURIUpdated(tokenId, getTokenURI(tokenId));
    }

    function levelUpByContribution(
        uint256 tokenId,
        uint increaseBy
    ) public onlyOwner {
        // Update the level directly
        uint256 newLevel = tokenValues[tokenId].level + increaseBy;

        // Update the struct directly
        tokenValues[tokenId].level = newLevel;

        checkLevelsAndTokenValue(tokenId);

        // Emit an event to set the token URI dynamically
        emit TokenURIUpdated(tokenId, getTokenURI(tokenId));
    }

    function getLevels(uint256 tokenId) public view returns (string memory) {
        uint256 levels = tokenValues[tokenId].level;
        return levels.toString();
    }

    function tradeLevels(
        uint256 _fromTokenId,
        uint256 _toTokenId,
        uint256 value
    ) public {
        address fromOwner = ownerOf(_fromTokenId);
        address toOwner = ownerOf(_toTokenId);

        require(
            fromOwner != address(0) && toOwner != address(0),
            "Invalid token IDs"
        );
        require(fromOwner == msg.sender, "Permission denied");

        // Check if _fromTokenId has enough levels
        require(
            tokenValues[_fromTokenId].level >= value,
            "Insufficient levels to trade"
        );

        // Update the value amount
        tokenValues[_fromTokenId].level =
            tokenValues[_fromTokenId].level -
            value;
        tokenValues[_toTokenId].level = tokenValues[_toTokenId].level + value;

        checkLevelsAndTokenValue(_fromTokenId);
        checkLevelsAndTokenValue(_toTokenId);

        // Emit events to set the token URIs dynamically
        emit TokenURIUpdated(_fromTokenId, getTokenURI(_fromTokenId));
        emit TokenURIUpdated(_toTokenId, getTokenURI(_toTokenId));
    }

    function checkLevelsAndTokenValue(uint _tokenId) internal {
        TokenValue storage token = tokenValues[_tokenId];

        if (token.level < 10 && !(token.attackSecondary == Attack.Empty)) {
            tokenValues[_tokenId].attackSecondary = Attack.Empty;
        } else if (
            token.level >= 10 && (token.attackSecondary == Attack.Empty)
        ) {
            tokenValues[_tokenId].attackSecondary = generateAttacks(
                token.class
            );
        }

        if (token.level < 100 && !(token.attackTertiary == Attack.Empty)) {
            tokenValues[_tokenId].attackTertiary = Attack.Empty;
        } else if (
            token.level >= 100 && (token.attackTertiary == Attack.Empty)
        ) {
            tokenValues[_tokenId].attackTertiary = generateAttacks(token.class);
        }
    }

    function getTokenURI(
        uint256 _tokenId
    ) internal view returns (string memory) {
        TokenValue memory token = tokenValues[_tokenId];
        string memory svgData = generateSvg(
            token.level,
            token.name,
            token.colorPrimary,
            token.colorSecondary,
            token.class,
            token.attackPrimary,
            token.attackSecondary,
            token.attackTertiary
        );

        string memory dataURI = string(
            abi.encodePacked(
                "{",
                '"name":"',
                token.name,
                '",',
                '"description":"',
                token.description,
                '",',
                '"image_data": "',
                svgData,
                '",',
                '"external_url": "https://www.youtube.com/itrebels",',
                getTokenAttributes(_tokenId),
                "}"
            )
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(bytes(dataURI))
                )
            );
    }

    function getTokenAttributes(
        uint256 _tokenId
    ) internal view returns (string memory) {
        TokenValue memory token = tokenValues[_tokenId];
        return
            string(
                abi.encodePacked(
                    '"attributes": [',
                    encodeAttribute("primaryColor", token.colorPrimary, false),
                    encodeAttribute(
                        "secondaryColor",
                        token.colorSecondary,
                        false
                    ),
                    encodeAttribute("class", className[token.class], false),
                    encodeAttribute(
                        "attackPrimary",
                        attackName[token.attackPrimary],
                        false
                    ),
                    encodeAttribute(
                        "attackSecondary",
                        attackName[token.attackSecondary],
                        false
                    ),
                    encodeAttribute(
                        "attackTertiary",
                        attackName[token.attackTertiary],
                        false
                    ),
                    encodeAttribute(
                        "level",
                        Strings.toString(token.level),
                        true
                    ),
                    "]"
                )
            );
    }

    function encodeAttribute(
        string memory traitType,
        string memory value,
        bool isLast
    ) internal pure returns (string memory) {
        if (isLast) {
            return
                string(
                    abi.encodePacked(
                        '{ "trait_type" : "',
                        traitType,
                        '", "value": "',
                        value,
                        '"}'
                    )
                );
        }
        return
            string(
                abi.encodePacked(
                    '{ "trait_type" : "',
                    traitType,
                    '", "value": "',
                    value,
                    '"},'
                )
            );
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        address owner = ownerOf(tokenId);
        require(owner != address(0), "URI query for nonexistent token");

        TokenValue memory _tokenValue = tokenValues[tokenId];

        string memory svgData = generateSvg(
            _tokenValue.level,
            _tokenValue.name,
            _tokenValue.colorPrimary,
            _tokenValue.colorSecondary,
            _tokenValue.class,
            _tokenValue.attackPrimary,
            _tokenValue.attackSecondary,
            _tokenValue.attackTertiary
        );

        string memory dataURI = string(
            abi.encodePacked(
                "{",
                '"name":"',
                _tokenValue.name,
                '",',
                '"description":"',
                _tokenValue.description,
                '",',
                '"image_data": "',
                svgData,
                '",',
                '"external_url": "https://www.youtube.com/itrebels",',
                getTokenAttributes(tokenId),
                "}"
            )
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(bytes(dataURI))
                )
            );
    }

    function withdraw() public payable onlyOwner {
        (bool os, ) = payable(owner()).call{value: address(this).balance}("");
        require(os);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address to,
        uint256 tokenId,
        address auth
    )
        internal
        override(ERC721, ERC721Enumerable, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
