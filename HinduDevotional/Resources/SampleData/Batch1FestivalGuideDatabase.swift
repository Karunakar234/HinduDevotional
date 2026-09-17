import Foundation

enum Batch1FestivalGuideDatabase {
    static let guides: [FestivalGuide] = [
        ganeshChaturthi,
        varalakshmiVratam,
        satyanarayanaVratam,
        ugadi,
        sriRamaNavami,
        krishnaJanmashtami,
        mahaShivaratri,
        deepavali,
        navaratri,
        vijayadashami
    ]

    static func guide(for title: String) -> FestivalGuide? {
        let normalizedTitle = title.lowercased()
        return guides.first { guide in
            normalizedTitle.contains(guide.nameEnglish.lowercased())
            || guide.alternativeNames.contains { normalizedTitle.contains($0.lowercased()) }
        }
    }

    static let commonSources = [
        FestivalSource(
            id: "hta-panchang",
            title: "Hindu Temple of Atlanta Panchang",
            sourceType: "Temple Panchang",
            url: "https://hindutempleofatlanta.org/pages/panchang",
            notes: "Used as a Panchang category and date-reference source where applicable; proprietary calendar content is not copied."
        ),
        FestivalSource(
            id: "religious-review-required",
            title: "Religious reviewer required",
            sourceType: "Content review",
            url: nil,
            notes: "Exact mantras, Sankalpam, vratam kathas, puja timing rules, and translations require qualified review before publication."
        )
    ]

    static let ganeshChaturthi = FestivalGuide(
        id: "ganesh-chaturthi",
        nameEnglish: "Ganesh Chaturthi",
        nameTelugu: "వినాయక చవితి",
        nameSanskrit: "गणेश चतुर्थी",
        alternativeNames: ["Vinayaka Chavithi", "Vinayaka Chaturthi", "Ganeshotsav", "Ganesha Chaturthi"],
        category: .ganesha,
        deity: ["Ganesha"],
        associatedDeities: ["Shiva", "Parvati"],
        panchang: FestivalPanchangRule(tithi: "Chaturthi", paksha: "Shukla Paksha", masa: "Bhadrapada", nakshatraRequirement: "No universal nakshatra requirement", sunriseRule: "Date depends on local Panchang and festival rule", sunsetRule: "Not sunset-based for all traditions"),
        festivalDateRule: verified("Observed on Bhadrapada Shukla Chaturthi according to local Panchang tradition.", "స్థానిక పంచాంగ సంప్రదాయం ప్రకారం భాద్రపద శుక్ల చవితి నాడు జరుపుకుంటారు.", .traditionSummary),
        pujaTimeRule: needsVerification("Madhyahna or locally prescribed Chaturthi puja timing must be calculated from the user's location and selected tradition.", "పూజ సమయం స్థానిక స్థానం మరియు సంప్రదాయం ఆధారంగా లెక్కించాలి."),
        significance: verified(FestivalSampleData.ganeshChaturthi.overview, "వినాయక చవితి శ్రీ గణేశుని స్మరించే పండుగ. కొత్త కార్యాలకు ముందు గణేశుని ప్రార్థించే సంప్రదాయాన్ని ఇది గుర్తు చేస్తుంది.", .traditionSummary),
        history: needsVerification("Historical development and public Ganeshotsav context require reviewed source attribution.", "చారిత్రక వివరాలు సమీక్షించిన మూలాలతో జోడించాలి."),
        legend: needsVerification("Traditional Ganesha birth and Chaturthi stories vary by Purana, region, and family tradition.", "గణేశుని కథలు పురాణం, ప్రాంతం, కుటుంబ సంప్రదాయం ఆధారంగా మారవచ్చు."),
        scripturalBackground: needsVerification("Scriptural references must be added only with verified citations.", "శాస్త్రీయ మూలాలు ధృవీకరించిన తరువాత మాత్రమే జోడించాలి."),
        regionalTraditions: [
            RegionalVariation(tradition: "Telugu / Andhra-Telangana", region: "South India", descriptionEnglish: "Homes commonly prepare undrallu, kudumulu, modak-like offerings, and perform nimajjanam according to family practice.", descriptionTelugu: "తెలుగు కుటుంబాలలో ఉండ్రాళ్లు, కుడుములు వంటి నైవేద్యాలు చేసి కుటుంబ సంప్రదాయం ప్రకారం నిమజ్జనం చేస్తారు.", status: .traditionSummary),
            RegionalVariation(tradition: "Maharashtra", region: "Western India", descriptionEnglish: "Public Ganeshotsav and community mandals are especially prominent.", descriptionTelugu: "మహారాష్ట్రలో సామూహిక గణేశోత్సవం ప్రముఖంగా ఉంటుంది.", status: .traditionSummary)
        ],
        pujaItems: ganeshItems,
        preparationSteps: ganeshPreparation,
        pujaSetup: ganeshSetup,
        pujaModes: ganeshPujaModes,
        mantras: [requiresText("ganesha-prayer", "Ganesha Prayer", "గణేశ ప్రార్థన", "Exact mantra text requires verified source before display.")],
        slokas: [requiresText("ganesha-slokas", "Ganesha Slokas", "గణేశ శ్లోకాలు", "Sloka text and translations require source review.")],
        ashtottaram: requiresText("ganesha-ashtottaram", "Ganesha Ashtottaram", "గణేశ అష్టోత్తరం", "Full 108 names require verified source and language review."),
        sahasranamam: nil,
        vratamKatha: requiresText("ganesha-katha", "Ganesh Chaturthi Katha", "వినాయక చవితి కథ", "Katha varies by region and must be sourced."),
        naivedyam: ganeshFood,
        prasadam: ganeshFood,
        fastingRules: verified("Some devotees observe fasting or dietary restraint; practice varies by family and region and should not be treated as a medical requirement.", "కొంతమంది ఉపవాసం లేదా నియమాలు పాటిస్తారు; ఇది కుటుంబం మరియు ప్రాంతం ఆధారంగా మారుతుంది.", .traditionSummary),
        paranaRules: needsVerification("Parana rules, where followed, require tradition-specific guidance.", "పారణ నియమాలు సంప్రదాయం ఆధారంగా ధృవీకరించాలి."),
        dos: [instruction("Prepare the puja area calmly and safely.", "పూజా స్థలాన్ని శుభ్రంగా, సురక్షితంగా సిద్ధం చేయండి.")],
        donts: [instruction("Do not present one family procedure as universal for all Hindus.", "ఒక కుటుంబ విధానాన్ని అందరికీ వర్తించే విధానంగా చూపకండి.")],
        afterPujaSteps: [instruction("Distribute prasadam and save family notes if desired.", "ప్రసాదం పంచి, కావాలంటే కుటుంబ గమనికలు సేవ్ చేయండి.")],
        visarjanSteps: ganeshVisarjan,
        templeTraditions: [needsVerification("Temple-specific utsava and visarjan practices must be sourced per temple.", "ఆలయ సంప్రదాయాలు ఆయా ఆలయ మూలాలతో జోడించాలి.")],
        sources: commonSources
    )

    static let varalakshmiVratam = templateGuide(
        id: "varalakshmi-vratam",
        english: "Varalakshmi Vratam",
        telugu: "వరలక్ష్మీ వ్రతం",
        sanskrit: "वरलक्ष्मी व्रतम्",
        alternatives: ["Varalakshmi Puja", "Vara Lakshmi Vratam"],
        category: .shakti,
        deity: ["Lakshmi", "Varalakshmi"],
        panchang: FestivalPanchangRule(tithi: "Friday observance", paksha: "Shravana Masa tradition-dependent", masa: "Shravana", nakshatraRequirement: "None universally", sunriseRule: "Shravana Friday rule requires calendar tradition", sunsetRule: "Not primarily sunset-based"),
        significanceEnglish: "A Lakshmi vratam traditionally observed for auspiciousness, family wellbeing, and gratitude. Telugu and South Indian homes often prepare kalasham, toram, kumkum archana, vratam katha, and naivedyam.",
        significanceTelugu: "శ్రావణ మాసంలో లక్ష్మీదేవిని ఆరాధించే వ్రతం. తెలుగు కుటుంబాలలో కలశం, తోరం, కుంకుమార్చన, వ్రత కథ, నైవేద్యం ముఖ్యంగా ఉంటాయి.",
        requiredProcedure: "Previous-day cleaning, muggu, mandapam, kalasham, mango leaves, coconut, Lakshmi face or image where used, toram preparation, Ganapati Puja, Sankalpam, Kalasha Puja, Varalakshmi Avahanam, Lakshmi Ashtottaram, Kumkum Archana, Toram Puja, Vratam Katha, Naivedyam, Tambulam, Aarti, Pradakshina, Namaskaram.",
        requiredProcedureTelugu: "ముందురోజు శుభ్రపరచడం, ముగ్గు, మండపం, కలశం, మామిడి ఆకులు, కొబ్బరి, లక్ష్మీ ముఖం లేదా చిత్రం, తోరం సిద్ధం, గణపతి పూజ, సంకల్పం, కలశ పూజ, వరలక్ష్మీ ఆవాహనం, లక్ష్మీ అష్టోత్తరం, కుంకుమార్చన, తోరం పూజ, వ్రత కథ, నైవేద్యం, తాంబూలం, హారతి, ప్రదక్షిణ, నమస్కారం."
    )

    static let satyanarayanaVratam = templateGuide(
        id: "satyanarayana-vratam",
        english: "Sri Satyanarayana Swamy Vratam",
        telugu: "శ్రీ సత్యనారాయణ స్వామి వ్రతం",
        sanskrit: "सत्यनारायण व्रतम्",
        alternatives: ["Satyanarayana Puja", "Satyanarayana Vratam", "Satyanarayana Swamy Puja"],
        category: .vishnu,
        deity: ["Vishnu", "Satyanarayana Swamy"],
        panchang: FestivalPanchangRule(tithi: "Purnima or chosen auspicious day", paksha: "Tradition-dependent", masa: "Monthly or occasion-based", nakshatraRequirement: "None universally", sunriseRule: "Auspicious timing requires Panchang", sunsetRule: "Can be performed by family tradition at suitable time"),
        significanceEnglish: "A Vishnu/Satyanarayana vratam commonly performed for gratitude, family milestones, and devotional worship. It is often structured as Shodashopachara Puja followed by vratam katha and prasadam distribution.",
        significanceTelugu: "కృతజ్ఞత, కుటుంబ శుభకార్యాలు, భక్తి కోసం చేసే విష్ణు/సత్యనారాయణ వ్రతం. షోడశోపచార పూజ, వ్రత కథ, ప్రసాదం పంచడం ముఖ్యమైన భాగాలు.",
        requiredProcedure: "Mandapam, kalasham, Satyanarayana image, Ganapati Puja, Sankalpam, Kalasha Puja, Navagraha Puja where followed, Satyanarayana Dhyanam, Avahanam, Shodashopachara Puja, Vishnu Archana, Naivedyam, Vratam Katha, Aarti, Mantra Pushpam, Pradakshina, Namaskaram, Prasadam distribution.",
        requiredProcedureTelugu: "మండపం, కలశం, సత్యనారాయణ చిత్రం, గణపతి పూజ, సంకల్పం, కలశ పూజ, నవగ్రహ పూజ అవసరమైతే, సత్యనారాయణ ధ్యానం, ఆవాహనం, షోడశోపచార పూజ, విష్ణు అర్చన, నైవేద్యం, వ్రత కథ, హారతి, మంత్రపుష్పం, ప్రదక్షిణ, నమస్కారం, ప్రసాదం పంచడం."
    )

    static let ugadi = templateGuide(id: "ugadi", english: "Ugadi", telugu: "ఉగాది", sanskrit: "युगादि", alternatives: ["Yugadi", "Telugu New Year"], category: .newYearSpring, deity: ["Ganesha", "Family Deity"], panchang: FestivalPanchangRule(tithi: "Pratipada", paksha: "Shukla Paksha", masa: "Chaitra", nakshatraRequirement: "None universally", sunriseRule: "Observed according to local Panchang new year day", sunsetRule: "Not sunset-based"), significanceEnglish: "Telugu and Kannada New Year, traditionally marked by cleaning, muggu, mango-leaf toranam, new clothes, deity puja, Panchanga Shravanam, and Ugadi Pachadi.", significanceTelugu: "తెలుగు మరియు కన్నడ నూతన సంవత్సరం. శుభ్రపరచడం, ముగ్గు, మామిడి తోరణం, కొత్త బట్టలు, దేవతా పూజ, పంచాంగ శ్రవణం, ఉగాది పచ్చడి సంప్రదాయం.", requiredProcedure: "Oil bath where followed, house cleaning, muggu, mango-leaf toranam, Ganapati prayer, Sankalpam, new-year prayer, Panchanga Shravanam, Ugadi Pachadi, Naivedyam, Aarti, elders' blessings.", requiredProcedureTelugu: "అభ్యంగ స్నానం, ఇంటి శుభ్రత, ముగ్గు, మామిడి తోరణం, గణపతి ప్రార్థన, సంకల్పం, నూతన సంవత్సర ప్రార్థన, పంచాంగ శ్రవణం, ఉగాది పచ్చడి, నైవేద్యం, హారతి, పెద్దల ఆశీర్వాదం.")

    static let sriRamaNavami = templateGuide(id: "sri-rama-navami", english: "Sri Rama Navami", telugu: "శ్రీరామ నవమి", sanskrit: "राम नवमी", alternatives: ["Rama Navami"], category: .newYearSpring, deity: ["Rama", "Sita", "Lakshmana", "Hanuman"], panchang: FestivalPanchangRule(tithi: "Navami", paksha: "Shukla Paksha", masa: "Chaitra", nakshatraRequirement: "None universally", sunriseRule: "Local Panchang rule required", sunsetRule: "Not sunset-based"), significanceEnglish: "Celebrates Sri Rama and dharma-centered living. Telugu traditions often include Sita-Rama worship, Ramayana reading, Rama Nama, panakam, and vadapappu.", significanceTelugu: "శ్రీరాముడి ఆరాధన మరియు ధర్మాన్ని స్మరించే పండుగ. సీతారామ పూజ, రామాయణ పఠనం, రామనామం, పానకం, వడపప్పు తెలుగు సంప్రదాయాలలో ముఖ్యమైనవి.", requiredProcedure: "Rama Puja, Sita-Rama worship, Dhyanam, Sankalpam, Abhishekam where followed, Alankaram, Archana, Rama Ashtottaram, Ramayana reading, Rama Nama chanting, Panakam and Vadapappu Naivedyam, Aarti.", requiredProcedureTelugu: "రామ పూజ, సీతారామ ఆరాధన, ధ్యానం, సంకల్పం, అభిషేకం అవసరమైతే, అలంకారం, అర్చన, రామ అష్టోత్తరం, రామాయణ పఠనం, రామనామ జపం, పానకం వడపప్పు నైవేద్యం, హారతి.")

    static let krishnaJanmashtami = templateGuide(id: "krishna-janmashtami", english: "Krishna Janmashtami", telugu: "శ్రీకృష్ణ జన్మాష్టమి", sanskrit: "कृष्ण जन्माष्टमी", alternatives: ["Gokulashtami", "Sri Jayanthi", "Krishnashtami"], category: .krishna, deity: ["Krishna"], panchang: FestivalPanchangRule(tithi: "Ashtami", paksha: "Krishna Paksha", masa: "Shravana or Bhadrapada by tradition", nakshatraRequirement: "Rohini relevance varies by tradition and does not always overlap", sunriseRule: "Local Panchang and tradition required", sunsetRule: "Midnight/Nishita worship where followed"), significanceEnglish: "Celebrates the birth of Sri Krishna. Observances may include fasting, cradle decoration, Krishna footprints, Bhagavata or Gita reading, bhajans, midnight worship, and parana by tradition.", significanceTelugu: "శ్రీకృష్ణ జన్మోత్సవం. ఉపవాసం, ఊయల అలంకారం, కృష్ణ పాదముద్రలు, భాగవతం లేదా గీతా పఠనం, భజనలు, అర్ధరాత్రి పూజ, పారణ సంప్రదాయం ప్రకారం ఉంటాయి.", requiredProcedure: "Ganapati prayer, Sankalpam, Krishna Dhyanam, Abhishekam, Vastram, Alankaram, Tulasi and flowers, Archana, Gita or Bhagavata reading, Bhajans, Naivedyam, Midnight worship where appropriate, Aarti, Cradle ceremony, Prasadam, Parana.", requiredProcedureTelugu: "గణపతి ప్రార్థన, సంకల్పం, కృష్ణ ధ్యానం, అభిషేకం, వస్త్రం, అలంకారం, తులసి పుష్పాలు, అర్చన, గీతా లేదా భాగవత పఠనం, భజనలు, నైవేద్యం, అర్ధరాత్రి పూజ, హారతి, ఊయల సేవ, ప్రసాదం, పారణ.")

    static let mahaShivaratri = templateGuide(id: "maha-shivaratri", english: "Maha Shivaratri", telugu: "మహా శివరాత్రి", sanskrit: "महाशिवरात्रि", alternatives: ["Shivaratri"], category: .shiva, deity: ["Shiva"], panchang: FestivalPanchangRule(tithi: "Chaturdashi", paksha: "Krishna Paksha", masa: "Magha or Phalguna by tradition", nakshatraRequirement: "None universally", sunriseRule: "Local Panchang required", sunsetRule: "Night worship and Nishita/Prahara rules require location"), significanceEnglish: "A major Shiva observance centered on fasting where followed, night vigil, abhishekam, bilva offering, mantra japa, and four Praharas in some traditions.", significanceTelugu: "శివారాధనలో ప్రధానమైన పర్వదినం. ఉపవాసం, రాత్రి జాగరణ, అభిషేకం, బిల్వార్చన, మంత్రజపం, కొన్ని సంప్రదాయాలలో నాలుగు ప్రహరాల పూజ చేస్తారు.", requiredProcedure: "Preparation, fasting guidance, Pradosha consideration, night vigil, Shiva Dhyanam, Lingam Abhishekam, Bilva offering, Dhupa, Deepa, Naivedyam, Shiva mantras, Lingashtakam/Bilvashtakam where sourced, Aarti, next-day Parana guidance.", requiredProcedureTelugu: "సిద్ధత, ఉపవాస మార్గదర్శకం, ప్రదోష కాలం, రాత్రి జాగరణ, శివ ధ్యానం, లింగాభిషేకం, బిల్వార్పణం, ధూపం, దీపం, నైవేద్యం, శివ మంత్రాలు, మూలాలతో లింగాష్టకం/బిల్వాష్టకం, హారతి, మరుసటి రోజు పారణ.")

    static let deepavali = templateGuide(id: "deepavali", english: "Deepavali", telugu: "దీపావళి", sanskrit: "दीपावली", alternatives: ["Diwali", "Deepawali"], category: .deepavali, deity: ["Lakshmi", "Ganesha", "Krishna", "Dhanvantari"], panchang: FestivalPanchangRule(tithi: "Amavasya and related tithis", paksha: "Krishna Paksha", masa: "Ashvina/Kartika by tradition", nakshatraRequirement: "None universally", sunriseRule: "Festival-day rules vary", sunsetRule: "Lakshmi Puja often uses Pradosha-period rules by tradition"), significanceEnglish: "A multi-day festival cycle, not one uniform ritual. South Indian Telugu emphasis often includes Naraka Chaturdashi, oil bath, lamps, Lakshmi Puja, and family traditions.", significanceTelugu: "ఒకే విధమైన పూజ కాదు; అనేక రోజుల పండుగ చక్రం. తెలుగు సంప్రదాయంలో నరక చతుర్దశి, అభ్యంగ స్నానం, దీపాలు, లక్ష్మీ పూజ, కుటుంబ ఆచారాలు ముఖ్యమైనవి.", requiredProcedure: "Dhanteras, Naraka Chaturdashi, Deepavali, Lakshmi Puja, Govardhan Puja, Bali Padyami, Bhai Dooj should be separate guides. Lakshmi Puja includes cleaning, rangoli, diyas, Lakshmi-Ganesha altar, Sankalpam, Ganapati Puja, Kalasha Puja where followed, Lakshmi Dhyanam, Avahanam, Lakshmi Puja, Ashtottaram, Kumkum Archana, Naivedyam, Aarti, Prasadam.", requiredProcedureTelugu: "ధనత్రయోదశి, నరక చతుర్దశి, దీపావళి, లక్ష్మీ పూజ, గోవర్ధన పూజ, బలి పాడ్యమి, భాయ్ దూజ్ వేర్వేరు మార్గదర్శకాలుగా ఉండాలి. లక్ష్మీ పూజలో శుభ్రత, రంగోలి/ముగ్గు, దీపాలు, లక్ష్మీ-గణేశ ఆలయం, సంకల్పం, గణపతి పూజ, కలశ పూజ, లక్ష్మీ ధ్యానం, ఆవాహనం, లక్ష్మీ పూజ, అష్టోత్తరం, కుంకుమార్చన, నైవేద్యం, హారతి, ప్రసాదం.")

    static let navaratri = templateGuide(id: "navaratri", english: "Navaratri", telugu: "నవరాత్రి", sanskrit: "नवरात्रि", alternatives: ["Sharad Navaratri", "Devi Navaratri", "Dasara Navaratri"], category: .navaratri, deity: ["Durga", "Devi", "Lakshmi", "Saraswati"], panchang: FestivalPanchangRule(tithi: "Pratipada through Navami", paksha: "Shukla Paksha", masa: "Ashvina/Aswayuja for Sharad Navaratri", nakshatraRequirement: "None universally", sunriseRule: "Ghatasthapana and day rules require Panchang", sunsetRule: "Evening worship varies"), significanceEnglish: "A nine-night Devi festival with region-specific forms, colors, naivedyam, stories, and rituals. Telugu traditions may include Bommala Koluvu, Bathukamma, Saraswati Puja, Ayudha Puja, and Vijayadashami.", significanceTelugu: "దేవి ఆరాధనకు సంబంధించిన తొమ్మిది రాత్రుల పండుగ. ప్రాంతాలవారీగా రూపాలు, రంగులు, నైవేద్యం, కథలు మారుతాయి. తెలుగు సంప్రదాయంలో బొమ్మల కొలువు, బతుకమ్మ, సరస్వతి పూజ, ఆయుధ పూజ, విజయదశమి ఉంటాయి.", requiredProcedure: "Support Day 1 through Day 9 plus Vijayadashami separately, with deity/form by selected tradition, color where used, puja, mantra, naivedyam, story, and spiritual significance.", requiredProcedureTelugu: "1వ రోజు నుంచి 9వ రోజు వరకు మరియు విజయదశమి వేర్వేరుగా చూపాలి. ఎంచుకున్న సంప్రదాయం ప్రకారం దేవి రూపం, రంగు, పూజ, మంత్రం, నైవేద్యం, కథ, ఆధ్యాత్మిక ప్రాముఖ్యం చూపాలి.")

    static let vijayadashami = templateGuide(id: "vijayadashami", english: "Vijayadashami", telugu: "విజయదశమి", sanskrit: "विजयदशमी", alternatives: ["Dasara", "Dussehra"], category: .navaratri, deity: ["Durga", "Rama", "Saraswati"], panchang: FestivalPanchangRule(tithi: "Dashami", paksha: "Shukla Paksha", masa: "Ashvina/Aswayuja", nakshatraRequirement: "None universally", sunriseRule: "Local Panchang required", sunsetRule: "Aparahna/other rules vary by tradition"), significanceEnglish: "Marks victory and auspicious beginnings after Navaratri. Regional traditions include Durga Vijayadashami, Rama's victory themes, Vidyarambham, Ayudha Puja completion, and beginning new learning.", significanceTelugu: "నవరాత్రి తరువాత విజయాన్ని, శుభారంభాలను సూచించే పండుగ. దుర్గా విజయదశమి, శ్రీరామ విజయ భావన, విద్యారంభం, ఆయుధ పూజ ముగింపు, కొత్త విద్య ప్రారంభం ప్రాంతాలవారీగా ఉంటాయి.", requiredProcedure: "Conclude Navaratri worship, Saraswati/Ayudha Puja completion where followed, seek blessings, begin learning or auspicious work, perform Aarti and Prasadam distribution.", requiredProcedureTelugu: "నవరాత్రి పూజ ముగింపు, సరస్వతి/ఆయుధ పూజ ముగింపు, ఆశీర్వాదం, విద్య లేదా శుభకార్య ప్రారంభం, హారతి, ప్రసాదం పంచడం.")

    private static func templateGuide(id: String, english: String, telugu: String, sanskrit: String, alternatives: [String], category: FestivalGuideCategory, deity: [String], panchang: FestivalPanchangRule, significanceEnglish: String, significanceTelugu: String, requiredProcedure: String, requiredProcedureTelugu: String) -> FestivalGuide {
        FestivalGuide(
            id: id,
            nameEnglish: english,
            nameTelugu: telugu,
            nameSanskrit: sanskrit,
            alternativeNames: alternatives,
            category: category,
            deity: deity,
            associatedDeities: [],
            panchang: panchang,
            festivalDateRule: needsVerification("Exact yearly date must be calculated using location-aware Panchang rules for this festival.", "ఖచ్చితమైన తేదీ స్థానిక పంచాంగ నియమాలతో లెక్కించాలి."),
            pujaTimeRule: needsVerification("Puja muhurta must be calculated dynamically from location, timezone, tithi, nakshatra, sunrise/sunset, and tradition.", "పూజ ముహూర్తం స్థానం, సమయ మండలం, తిథి, నక్షత్రం, సూర్యోదయం/సూర్యాస్తమయం, సంప్రదాయం ఆధారంగా లెక్కించాలి."),
            significance: verified(significanceEnglish, significanceTelugu, .traditionSummary),
            history: needsVerification("Historical background requires source-backed review.", "చారిత్రక నేపథ్యం మూలాలతో సమీక్షించాలి."),
            legend: needsVerification("Festival story or vratam katha must be added from verified traditional sources.", "పండుగ కథ లేదా వ్రత కథ ధృవీకరించిన సంప్రదాయ మూలాలనుంచి జోడించాలి."),
            scripturalBackground: needsVerification("Scriptural references require exact citations and reviewer approval.", "శాస్త్రీయ మూలాలకు ఖచ్చితమైన సూచనలు మరియు సమీక్ష అవసరం."),
            regionalTraditions: [RegionalVariation(tradition: "Telugu / South Indian", region: "South India", descriptionEnglish: requiredProcedure, descriptionTelugu: requiredProcedureTelugu, status: .traditionSummary)],
            pujaItems: standardItems,
            preparationSteps: [instruction("Clean and prepare the puja space according to family tradition.", "కుటుంబ సంప్రదాయం ప్రకారం పూజా స్థలాన్ని శుభ్రపరచి సిద్ధం చేయండి.")],
            pujaSetup: [instruction("Arrange deity image or kalasham, lamp, water, flowers, naivedyam, and required offerings safely.", "దేవతా చిత్రం లేదా కలశం, దీపం, నీరు, పుష్పాలు, నైవేద్యం, అవసరమైన సమర్పణలను సురక్షితంగా అమర్చండి.")],
            pujaModes: [basicMode(requiredProcedure, requiredProcedureTelugu)],
            mantras: [requiresText("\(id)-mantra", "Festival Mantras", "పండుగ మంత్రాలు", "Exact mantra text requires verified sources.")],
            slokas: [requiresText("\(id)-slokas", "Slokas", "శ్లోకాలు", "Sloka text requires source and language review.")],
            ashtottaram: requiresText("\(id)-ashtottaram", "Ashtottaram", "అష్టోత్తరం", "Ashtottaram text requires verified source where applicable."),
            sahasranamam: nil,
            vratamKatha: requiresText("\(id)-katha", "Vratam Katha", "వ్రత కథ", "Katha must be sourced and reviewed before display."),
            naivedyam: standardFood,
            prasadam: standardFood,
            fastingRules: needsVerification("Fasting rules vary by tradition, health, age, and family practice; must be reviewed before publication.", "ఉపవాస నియమాలు సంప్రదాయం, ఆరోగ్యం, వయస్సు, కుటుంబ ఆచారం ఆధారంగా మారుతాయి; సమీక్ష అవసరం."),
            paranaRules: needsVerification("Parana timing must come from local Panchang where applicable.", "పారణ సమయం అవసరమైతే స్థానిక పంచాంగం ఆధారంగా లెక్కించాలి."),
            dos: [instruction("Follow family and regional tradition respectfully.", "కుటుంబ మరియు ప్రాంతీయ సంప్రదాయాన్ని గౌరవంగా అనుసరించండి.")],
            donts: [instruction("Do not treat one regional method as universal.", "ఒక ప్రాంతీయ విధానాన్ని సర్వసాధారణంగా చూపకండి.")],
            afterPujaSteps: [instruction("Share prasadam and conclude with gratitude.", "ప్రసాదం పంచి కృతజ్ఞతతో ముగించండి.")],
            visarjanSteps: [],
            templeTraditions: [needsVerification("Temple-specific procedures require temple source attribution.", "ఆలయ విధానాలకు ఆలయ మూలాల సూచన అవసరం.")],
            sources: commonSources
        )
    }

    static let ganeshItems = [
        FestivalPujaItem(nameEnglish: "Ganesha murti or image", nameTelugu: "గణేశ విగ్రహం లేదా చిత్రం", required: true, substitutions: ["Clean printed image"], notes: nil),
        FestivalPujaItem(nameEnglish: "Durva grass", nameTelugu: "దుర్వ గడ్డి", required: false, substitutions: ["Fresh flowers where durva is unavailable"], notes: "Regional availability varies."),
        FestivalPujaItem(nameEnglish: "Modak or regional prasadam", nameTelugu: "మోదకం లేదా ప్రాంతీయ ప్రసాదం", required: true, substitutions: ["Undrallu", "Kudumulu", "Laddu"], notes: nil)
    ]

    static let standardItems = [
        FestivalPujaItem(nameEnglish: "Deity image or kalasham", nameTelugu: "దేవతా చిత్రం లేదా కలశం", required: true, substitutions: [], notes: nil),
        FestivalPujaItem(nameEnglish: "Deepam", nameTelugu: "దీపం", required: true, substitutions: ["Electric lamp where flame is unsafe"], notes: nil),
        FestivalPujaItem(nameEnglish: "Flowers", nameTelugu: "పుష్పాలు", required: true, substitutions: ["Available fresh flowers"], notes: nil),
        FestivalPujaItem(nameEnglish: "Naivedyam", nameTelugu: "నైవేద్యం", required: true, substitutions: ["Fruit or simple homemade offering"], notes: nil)
    ]

    static let ganeshPreparation = [
        instruction("Clean the puja area and arrange a safe lamp position.", "పూజా స్థలాన్ని శుభ్రపరచి దీపాన్ని సురక్షితంగా అమర్చండి."),
        instruction("Prepare Ganesha image or murti, flowers, durva where available, water, lamp, incense where safe, and naivedyam.", "గణేశ చిత్రం లేదా విగ్రహం, పూలు, దుర్వ ఉంటే, నీరు, దీపం, ధూపం సురక్షితమైతే, నైవేద్యం సిద్ధం చేయండి.")
    ]

    static let ganeshSetup = [instruction("Place Ganesha on a clean platform with offerings arranged neatly.", "గణేశుని శుభ్రమైన పీఠంపై ఉంచి సమర్పణలను చక్కగా అమర్చండి.")]

    static let ganeshPujaModes = [
        PujaModeGuide(mode: .quick, steps: [
            step(1, "Light Deepam", "దీపం వెలిగించండి", "Light the lamp safely before Ganesha.", "గణేశుని ముందు దీపాన్ని సురక్షితంగా వెలిగించండి."),
            step(2, "Offer Flowers", "పుష్పాలు సమర్పించండి", "Offer flowers with devotion.", "భక్తితో పుష్పాలు సమర్పించండి."),
            step(3, "Naivedyam", "నైవేద్యం", "Offer modak, fruit, or regional prasadam.", "మోదకం, పండు, లేదా ప్రాంతీయ ప్రసాదం సమర్పించండి."),
            step(4, "Aarti", "హారతి", "Perform aarti according to family practice.", "కుటుంబ ఆచారం ప్రకారం హారతి చేయండి.")
        ]),
        PujaModeGuide(mode: .standard, steps: ganeshDetailedSteps),
        PujaModeGuide(mode: .detailed, steps: ganeshDetailedSteps)
    ]

    static let ganeshDetailedSteps = [
        step(1, "Preparation", "సిద్ధత", "Prepare the altar and puja items.", "పీఠం మరియు పూజా సామగ్రిని సిద్ధం చేయండి."),
        step(2, "Sthapana", "స్థాపన", "Install or place Ganesha respectfully.", "గణేశుని గౌరవంగా ప్రతిష్ఠించండి లేదా ఉంచండి."),
        step(3, "Achamanam", "ఆచమనం", "Perform Achamanam if it is part of your family tradition.", "మీ కుటుంబ సంప్రదాయంలో ఉంటే ఆచమనం చేయండి."),
        step(4, "Deepa Prajwalana", "దీప ప్రజ్వలన", "Light the lamp safely.", "దీపాన్ని సురక్షితంగా వెలిగించండి."),
        step(5, "Ganapati Prayer", "గణపతి ప్రార్థన", "Recite a verified Ganesha prayer from your tradition.", "మీ సంప్రదాయంలోని ధృవీకరించిన గణేశ ప్రార్థన చదవండి."),
        step(6, "Sankalpam", "సంకల్పం", "State Sankalpam using verified local Panchang details.", "ధృవీకరించిన స్థానిక పంచాంగ వివరాలతో సంకల్పం చేయండి."),
        step(7, "Kalasha Puja", "కలశ పూజ", "Perform Kalasha Puja where followed.", "సంప్రదాయం ఉంటే కలశ పూజ చేయండి."),
        step(8, "Dhyanam and Avahanam", "ధ్యానం మరియు ఆవాహనం", "Meditate on Ganesha and invite the deity according to tradition.", "గణేశుని ధ్యానించి సంప్రదాయం ప్రకారం ఆవాహనం చేయండి."),
        step(9, "Offerings", "ఉపచారాలు", "Offer asanam, padyam, arghyam, achamaniyam, snanam where followed, vastram, gandham, akshata, flowers, and durva.", "ఆసనం, పాద్యం, అర్ఘ్యం, ఆచమనీయం, స్నానం ఉంటే, వస్త్రం, గంధం, అక్షత, పుష్పాలు, దుర్వ సమర్పించండి."),
        step(10, "Archana", "అర్చన", "Recite Ganesha Ashtottaram only from verified source text.", "ధృవీకరించిన మూలం ఉన్న గణేశ అష్టోత్తరం మాత్రమే చదవండి."),
        step(11, "Dhupam and Deepam", "ధూపం మరియు దీపం", "Offer incense where safe and show the lamp.", "సురక్షితమైతే ధూపం సమర్పించి దీపం చూపండి."),
        step(12, "Naivedyam", "నైవేద్యం", "Offer modak, undrallu, kudumulu, fruit, or family prasadam.", "మోదకం, ఉండ్రాళ్లు, కుడుములు, పండు, లేదా కుటుంబ ప్రసాదం సమర్పించండి."),
        step(13, "Harathi", "హారతి", "Perform karpura harathi or mangala harathi according to family practice.", "కుటుంబ ఆచారం ప్రకారం కర్పూర హారతి లేదా మంగళ హారతి చేయండి."),
        step(14, "Pradakshina and Namaskaram", "ప్రదక్షిణ మరియు నమస్కారం", "Offer pradakshina and namaskaram.", "ప్రదక్షిణ మరియు నమస్కారం చేయండి."),
        step(15, "Kshamapana and Prasadam", "క్షమాపణ మరియు ప్రసాదం", "Ask forgiveness for mistakes and distribute prasadam.", "తప్పుల కోసం క్షమాపణ కోరుకుని ప్రసాదం పంచండి.")
    ]

    static let ganeshFood = [
        FoodOffering(nameEnglish: "Modak", nameTelugu: "మోదకం", significanceEnglish: "A traditional sweet associated with Ganesha in many traditions.", significanceTelugu: "అనేక సంప్రదాయాలలో గణేశునికి సంబంధించిన తీపి నైవేద్యం.", dietaryNotes: ["Vegetarian"], status: .traditionSummary),
        FoodOffering(nameEnglish: "Undrallu / Kudumulu", nameTelugu: "ఉండ్రాళ్లు / కుడుములు", significanceEnglish: "Common Telugu offerings for Vinayaka Chavithi.", significanceTelugu: "వినాయక చవితికి తెలుగు సంప్రదాయంలో సాధారణ నైవేద్యాలు.", dietaryNotes: ["Vegetarian"], status: .traditionSummary)
    ]

    static let standardFood = [FoodOffering(nameEnglish: "Fruit or simple naivedyam", nameTelugu: "పండు లేదా సరళ నైవేద్యం", significanceEnglish: "A respectful vegetarian offering according to family tradition.", significanceTelugu: "కుటుంబ సంప్రదాయం ప్రకారం గౌరవప్రదమైన శాకాహార నైవేద్యం.", dietaryNotes: ["Vegetarian"], status: .traditionSummary)]

    static let ganeshVisarjan = [
        instruction("Perform final puja and aarti before visarjan or nimajjanam.", "నిమజ్జనం ముందు చివరి పూజ మరియు హారతి చేయండి."),
        instruction("Use environmentally responsible home immersion where appropriate and permitted.", "అనుకూలమైతే పర్యావరణానికి మేలు చేసే ఇంటి నిమజ్జనం చేయండి."),
        instruction("Practices vary by region, family, and local rules.", "ప్రాంతం, కుటుంబం, స్థానిక నియమాల ఆధారంగా ఆచారాలు మారుతాయి.")
    ]

    private static func basicMode(_ english: String, _ telugu: String) -> PujaModeGuide {
        PujaModeGuide(mode: .standard, steps: [step(1, "Puja Procedure", "పూజా విధానం", english, telugu)])
    }

    private static func step(_ number: Int, _ englishName: String, _ teluguName: String, _ englishInstruction: String, _ teluguInstruction: String) -> FestivalPujaStep {
        FestivalPujaStep(stepNumber: number, stepNameEnglish: englishName, stepNameTelugu: teluguName, requiredItems: [], instructionEnglish: englishInstruction, instructionTelugu: teluguInstruction, mantra: nil, repeatCount: nil, offering: nil, duration: nil, optional: false, tradition: "General home practice; varies by family and region", verificationStatus: .traditionSummary)
    }

    private static func verified(_ english: String, _ telugu: String, _ status: VerificationStatus) -> VerifiedText {
        VerifiedText(english: english, telugu: telugu, status: status, sourceIds: [], notes: nil)
    }

    private static func needsVerification(_ english: String, _ telugu: String) -> VerifiedText {
        VerifiedText(english: english, telugu: telugu, status: .requiresVerification, sourceIds: ["religious-review-required"], notes: "Do not publish as final ritual guidance until reviewed.")
    }

    private static func instruction(_ english: String, _ telugu: String) -> LocalizedInstruction {
        LocalizedInstruction(english: english, telugu: telugu, status: .traditionSummary)
    }

    private static func requiresText(_ id: String, _ title: String, _ teluguTitle: String, _ notes: String) -> DevotionalText {
        DevotionalText(id: id, titleEnglish: title, titleTelugu: teluguTitle, sanskrit: nil, teluguScript: nil, transliteration: nil, meaningEnglish: nil, meaningTelugu: nil, sourceIds: ["religious-review-required"], status: .requiresVerification, notes: notes)
    }
}
