
    create table acquisitionmode (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table annotation (
        discriminator varchar2(31 char) not null,
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        ns varchar2(255 char),
        version number(10,0),
        boolValue number(1,0),
        textValue varchar2(255 char),
        doubleValue double precision,
        longValue number(19,0),
        termValue varchar2(255 char),
        timeValue timestamp,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        "file" number(19,0),
        primary key (id)
    );

    create table annotationannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table arc (
        lightsource_id number(19,0) not null,
        type number(19,0) not null,
        primary key (lightsource_id)
    );

    create table arctype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table binning (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table channel (
        id number(19,0) not null,
        alpha number(10,0),
        blue number(10,0),
        permissions number(19,0) not null,
        green number(10,0),
        red number(10,0),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        logicalChannel number(19,0) not null,
        pixels number(19,0) not null,
        statsInfo number(19,0),
        pixels_index number(10,0) not null,
        primary key (id),
        unique (pixels, pixels_index) deferrable initially deferred
    );

    create table channelannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table channelbinding (
        id number(19,0) not null,
        active number(1,0) not null,
        alpha number(10,0) not null,
        blue number(10,0) not null,
        coefficient double precision not null,
        permissions number(19,0) not null,
        green number(10,0) not null,
        inputEnd double precision not null,
        inputStart double precision not null,
        noiseReduction number(1,0) not null,
        red number(10,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        family number(19,0) not null,
        renderingDef number(19,0) not null,
        renderingDef_index number(10,0) not null,
        primary key (id),
        unique (renderingDef, renderingDef_index) deferrable initially deferred
    );

    create table checksumalgorithm (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table codomainmapcontext (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        renderingDef number(19,0) not null,
        renderingDef_index number(10,0) not null,
        primary key (id),
        unique (renderingDef, renderingDef_index) deferrable initially deferred
    );

    create table contrastmethod (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table contraststretchingcontext (
        xend number(10,0) not null,
        xstart number(10,0) not null,
        yend number(10,0) not null,
        ystart number(10,0) not null,
        codomainmapcontext_id number(19,0) not null,
        primary key (codomainmapcontext_id)
    );

    create table correction (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table count_Annotation_annotation13 (
        Annotation_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Annotation_id, owner_id)
    );

    create table count_Channel_annotationLin10 (
        Channel_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Channel_id, owner_id)
    );

    create table count_Dataset_annotationLin10 (
        Dataset_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Dataset_id, owner_id)
    );

    create table count_Dataset_imageLinks_by5 (
        Dataset_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Dataset_id, owner_id)
    );

    create table count_Dataset_projectLinks_7 (
        Dataset_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Dataset_id, owner_id)
    );

    create table count_ExperimenterGroup_ann20 (
        ExperimenterGroup_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (ExperimenterGroup_id, owner_id)
    );

    create table count_Experimenter_annotati15 (
        Experimenter_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Experimenter_id, owner_id)
    );

    create table count_Fileset_annotationLin10 (
        Fileset_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Fileset_id, owner_id)
    );

    create table count_Fileset_jobLinks_by_o3 (
        Fileset_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Fileset_id, owner_id)
    );

    create table count_FilterSet_emissionFil15 (
        FilterSet_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (FilterSet_id, owner_id)
    );

    create table count_FilterSet_excitationF17 (
        FilterSet_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (FilterSet_id, owner_id)
    );

    create table count_Filter_emissionFilter12 (
        Filter_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Filter_id, owner_id)
    );

    create table count_Filter_excitationFilt14 (
        Filter_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Filter_id, owner_id)
    );

    create table count_Image_annotationLinks8 (
        Image_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Image_id, owner_id)
    );

    create table count_Image_datasetLinks_by5 (
        Image_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Image_id, owner_id)
    );

    create table count_Job_originalFileLinks8 (
        Job_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Job_id, owner_id)
    );

    create table count_LightPath_emissionFil15 (
        LightPath_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (LightPath_id, owner_id)
    );

    create table count_LightPath_excitationF17 (
        LightPath_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (LightPath_id, owner_id)
    );

    create table count_Namespace_annotationL12 (
        Namespace_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Namespace_id, owner_id)
    );

    create table count_Node_annotationLinks_7 (
        Node_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Node_id, owner_id)
    );

    create table count_OriginalFile_annotati15 (
        OriginalFile_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (OriginalFile_id, owner_id)
    );

    create table count_OriginalFile_pixelsFi14 (
        OriginalFile_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (OriginalFile_id, owner_id)
    );

    create table count_Pixels_annotationLink9 (
        Pixels_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Pixels_id, owner_id)
    );

    create table count_Pixels_pixelsFileMaps8 (
        Pixels_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Pixels_id, owner_id)
    );

    create table count_PlaneInfo_annotationL12 (
        PlaneInfo_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (PlaneInfo_id, owner_id)
    );

    create table count_PlateAcquisition_anno19 (
        PlateAcquisition_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (PlateAcquisition_id, owner_id)
    );

    create table count_Plate_annotationLinks8 (
        Plate_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Plate_id, owner_id)
    );

    create table count_Plate_screenLinks_by_4 (
        Plate_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Plate_id, owner_id)
    );

    create table count_Project_annotationLin10 (
        Project_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Project_id, owner_id)
    );

    create table count_Project_datasetLinks_7 (
        Project_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Project_id, owner_id)
    );

    create table count_Reagent_annotationLin10 (
        Reagent_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Reagent_id, owner_id)
    );

    create table count_Reagent_wellLinks_by_4 (
        Reagent_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Reagent_id, owner_id)
    );

    create table count_Roi_annotationLinks_b6 (
        Roi_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Roi_id, owner_id)
    );

    create table count_Screen_annotationLink9 (
        Screen_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Screen_id, owner_id)
    );

    create table count_Screen_plateLinks_by_4 (
        Screen_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Screen_id, owner_id)
    );

    create table count_Session_annotationLin10 (
        Session_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Session_id, owner_id)
    );

    create table count_WellSample_annotation13 (
        WellSample_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (WellSample_id, owner_id)
    );

    create table count_Well_annotationLinks_7 (
        Well_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Well_id, owner_id)
    );

    create table count_Well_reagentLinks_by_4 (
        Well_id number(19,0) not null,
        count number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (Well_id, owner_id)
    );

    create table dataset (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        name varchar2(255 char) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table datasetannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table datasetimagelink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table dbpatch (
        id number(19,0) not null,
        currentPatch number(10,0) not null,
        currentVersion varchar2(255 char) not null,
        permissions number(19,0) not null,
        finished timestamp,
        message varchar2(255 char),
        previousPatch number(10,0) not null,
        previousVersion varchar2(255 char) not null,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table detector (
        id number(19,0) not null,
        amplificationGain double precision,
        permissions number(19,0) not null,
        gain double precision,
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        offsetValue double precision,
        serialNumber varchar2(255 char),
        version number(10,0),
        voltage double precision,
        zoom double precision,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        instrument number(19,0) not null,
        type number(19,0) not null,
        primary key (id)
    );

    create table detectorsettings (
        id number(19,0) not null,
        permissions number(19,0) not null,
        gain double precision,
        integration number(10,0),
        offsetValue double precision,
        readOutRate double precision,
        version number(10,0),
        voltage double precision,
        zoom double precision,
        binning number(19,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        detector number(19,0) not null,
        primary key (id),
        check (integration > 0)
    );

    create table detectortype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table dichroic (
        id number(19,0) not null,
        permissions number(19,0) not null,
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        serialNumber varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        instrument number(19,0) not null,
        primary key (id)
    );

    create table dimensionorder (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table event (
        id number(19,0) not null,
        permissions number(19,0) not null,
        status varchar2(255 char),
        time timestamp not null,
        containingEvent number(19,0),
        external_id number(19,0) unique,
        experimenter number(19,0) not null,
        experimenterGroup number(19,0) not null,
        "session" number(19,0) not null,
        type number(19,0) not null,
        primary key (id)
    );

    create table eventlog (
        id number(19,0) not null,
        action varchar2(255 char) not null,
        permissions number(19,0) not null,
        entityId number(19,0) not null,
        entityType varchar2(255 char) not null,
        external_id number(19,0) unique,
        event number(19,0) not null,
        primary key (id)
    );

    create table eventtype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table experiment (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        type number(19,0) not null,
        primary key (id)
    );

    create table experimenter (
        id number(19,0) not null,
        permissions number(19,0) not null,
        email varchar2(255 char),
        firstName varchar2(255 char) not null,
        institution varchar2(255 char),
        lastName varchar2(255 char) not null,
        middleName varchar2(255 char),
        omeName varchar2(255 char) not null unique,
        version number(10,0),
        external_id number(19,0) unique,
        primary key (id)
    );

    create table experimenterannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table experimentergroup (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        name varchar2(255 char) not null unique,
        version number(10,0),
        external_id number(19,0) unique,
        primary key (id)
    );

    create table experimentergroupannotation3 (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table experimenttype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table externalinfo (
        id number(19,0) not null,
        permissions number(19,0) not null,
        entityId number(19,0) not null,
        entityType varchar2(255 char) not null,
        lsid varchar2(255 char),
        uuid varchar2(255 char),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        primary key (id)
    );

    create table family (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table filament (
        lightsource_id number(19,0) not null,
        type number(19,0) not null,
        primary key (lightsource_id)
    );

    create table filamenttype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table fileset (
        id number(19,0) not null,
        permissions number(19,0) not null,
        templatePrefix varchar2(255 char) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table filesetannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table filesetentry (
        id number(19,0) not null,
        clientPath varchar2(255 char) not null,
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        fileset number(19,0) not null,
        originalFile number(19,0) not null,
        fileset_index number(10,0) not null,
        primary key (id),
        unique (fileset, fileset_index) deferrable initially deferred
    );

    create table filesetjoblink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        parent_index number(10,0) not null,
        primary key (id),
        unique (parent, parent_index) deferrable initially deferred,
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table filesetversioninfo (
        id number(19,0) not null,
        bioformatsReader varchar2(255 char) not null,
        bioformatsVersion varchar2(255 char) not null,
        permissions number(19,0) not null,
        locale varchar2(255 char) not null,
        omeroVersion varchar2(255 char) not null,
        osArchitecture varchar2(255 char) not null,
        osName varchar2(255 char) not null,
        osVersion varchar2(255 char) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table filter (
        id number(19,0) not null,
        permissions number(19,0) not null,
        filterWheel varchar2(255 char),
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        serialNumber varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        instrument number(19,0) not null,
        transmittanceRange number(19,0),
        type number(19,0),
        primary key (id)
    );

    create table filterset (
        id number(19,0) not null,
        permissions number(19,0) not null,
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        serialNumber varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        dichroic number(19,0),
        instrument number(19,0) not null,
        primary key (id)
    );

    create table filtersetemissionfilterlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table filtersetexcitationfilterlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table filtertype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table format (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table groupexperimentermap (
        id number(19,0) not null,
        permissions number(19,0) not null,
        owner number(1,0) not null,
        version number(10,0),
        child number(19,0) not null,
        external_id number(19,0) unique,
        parent number(19,0) not null,
        child_index number(10,0) not null,
        primary key (id),
        unique (parent, child) deferrable initially deferred,
        unique (child, child_index) deferrable initially deferred
    );

    create table illumination (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table image (
        id number(19,0) not null,
        acquisitionDate timestamp not null,
        archived number(1,0),
        description varchar2(255 char),
        permissions number(19,0) not null,
        name varchar2(255 char) not null,
        partial number(1,0),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        experiment number(19,0),
        fileset number(19,0),
        format number(19,0),
        imagingEnvironment number(19,0),
        instrument number(19,0),
        objectiveSettings number(19,0),
        stageLabel number(19,0),
        primary key (id)
    );

    create table imageannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table imagingenvironment (
        id number(19,0) not null,
        airPressure double precision,
        co2percent double precision,
        permissions number(19,0) not null,
        humidity double precision,
        temperature double precision,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id),
        check (humidity >= 0 and humidity <= 1 and co2percent >= 0 and co2percent <= 1)
    );

    create table immersion (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table importjob (
        imageDescription varchar2(255 char) not null,
        imageName varchar2(255 char) not null,
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table indexingjob (
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table instrument (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        microscope number(19,0),
        primary key (id)
    );

    create table integritycheckjob (
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table job (
        id number(19,0) not null,
        permissions number(19,0) not null,
        finished timestamp,
        groupname varchar2(255 char) not null,
        message varchar2(255 char) not null,
        scheduledFor timestamp not null,
        started timestamp,
        submitted timestamp not null,
        type varchar2(255 char) not null,
        username varchar2(255 char) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        status number(19,0) not null,
        primary key (id)
    );

    create table joboriginalfilelink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table jobstatus (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table laser (
        frequencyMultiplication number(10,0),
        pockelCell number(1,0),
        repetitionRate double precision,
        tuneable number(1,0),
        wavelength number(10,0),
        lightsource_id number(19,0) not null,
        laserMedium number(19,0) not null,
        pulse number(19,0),
        pump number(19,0),
        type number(19,0) not null,
        primary key (lightsource_id),
        check (frequencyMultiplication > 0 and wavelength > 0)
    );

    create table lasermedium (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table lasertype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table lightemittingdiode (
        lightsource_id number(19,0) not null,
        primary key (lightsource_id)
    );

    create table lightpath (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        dichroic number(19,0),
        primary key (id)
    );

    create table lightpathemissionfilterlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table lightpathexcitationfilterlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        parent_index number(10,0) not null,
        primary key (id),
        unique (parent, parent_index) deferrable initially deferred,
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table lightsettings (
        id number(19,0) not null,
        attenuation double precision,
        permissions number(19,0) not null,
        version number(10,0),
        wavelength number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        lightSource number(19,0) not null,
        microbeamManipulation number(19,0),
        primary key (id),
        check (attenuation >= 0 and attenuation <= 1 and wavelength > 0)
    );

    create table lightsource (
        id number(19,0) not null,
        permissions number(19,0) not null,
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        "power" double precision,
        serialNumber varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        instrument number(19,0) not null,
        primary key (id)
    );

    create table link (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table logicalchannel (
        id number(19,0) not null,
        permissions number(19,0) not null,
        emissionWave number(10,0),
        excitationWave number(10,0),
        fluor varchar2(255 char),
        name varchar2(255 char),
        ndFilter double precision,
        pinHoleSize double precision,
        pockelCellSetting number(10,0),
        samplesPerPixel number(10,0),
        version number(10,0),
        contrastMethod number(19,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        detectorSettings number(19,0),
        filterSet number(19,0),
        illumination number(19,0),
        lightPath number(19,0),
        lightSourceSettings number(19,0),
        "mode" number(19,0),
        otf number(19,0),
        photometricInterpretation number(19,0),
        primary key (id),
        check (excitationWave > 0 and emissionWave > 0 and samplesPerPixel > 0)
    );

    create table medium (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table metadataimportjob (
        job_id number(19,0) not null,
        versionInfo number(19,0) not null,
        primary key (job_id)
    );

    create table microbeammanipulation (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        experiment number(19,0) not null,
        type number(19,0) not null,
        primary key (id)
    );

    create table microbeammanipulationtype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table microscope (
        id number(19,0) not null,
        permissions number(19,0) not null,
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        serialNumber varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        type number(19,0) not null,
        primary key (id)
    );

    create table microscopetype (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table namespace (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        display number(1,0),
        keywords STRING_ARRAY,
        multivalued number(1,0),
        name varchar2(255 char) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table namespaceannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table node (
        id number(19,0) not null,
        conn varchar2(255 char) not null,
        permissions number(19,0) not null,
        down timestamp,
        scale number(10,0),
        up timestamp not null,
        uuid varchar2(255 char) not null unique,
        version number(10,0),
        external_id number(19,0) unique,
        primary key (id)
    );

    create table nodeannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table objective (
        id number(19,0) not null,
        calibratedMagnification double precision,
        permissions number(19,0) not null,
        iris number(1,0),
        lensNA double precision,
        lotNumber varchar2(255 char),
        manufacturer varchar2(255 char),
        model varchar2(255 char),
        nominalMagnification double precision,
        serialNumber varchar2(255 char),
        version number(10,0),
        workingDistance double precision,
        correction number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        immersion number(19,0) not null,
        instrument number(19,0) not null,
        primary key (id)
    );

    create table objectivesettings (
        id number(19,0) not null,
        correctionCollar double precision,
        permissions number(19,0) not null,
        refractiveIndex double precision,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        medium number(19,0),
        objective number(19,0) not null,
        primary key (id)
    );

    create table originalfile (
        id number(19,0) not null,
        atime timestamp,
        ctime timestamp,
        permissions number(19,0) not null,
        hash varchar2(255 char),
        mimetype varchar2(255 char),
        mtime timestamp,
        name varchar2(255 char) not null,
        path varchar2(255 char) not null,
        "size" number(19,0),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        hasher number(19,0),
        primary key (id)
    );

    create table originalfileannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table otf (
        id number(19,0) not null,
        permissions number(19,0) not null,
        opticalAxisAveraged number(1,0) not null,
        path varchar2(255 char) not null,
        sizeX number(10,0) not null,
        sizeY number(10,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        filterSet number(19,0),
        instrument number(19,0) not null,
        objective number(19,0) not null,
        pixelsType number(19,0) not null,
        primary key (id),
        check (sizeX > 0 and sizeY > 0)
    );

    create table parsejob (
        params BLOB,
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table photometricinterpretation (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table pixeldatajob (
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table pixels (
        id number(19,0) not null,
        permissions number(19,0) not null,
        methodology varchar2(255 char),
        physicalSizeX double precision,
        physicalSizeY double precision,
        physicalSizeZ double precision,
        sha1 varchar2(255 char) not null,
        significantBits number(10,0),
        sizeC number(10,0) not null,
        sizeT number(10,0) not null,
        sizeX number(10,0) not null,
        sizeY number(10,0) not null,
        sizeZ number(10,0) not null,
        timeIncrement double precision,
        version number(10,0),
        waveIncrement number(10,0),
        waveStart number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        dimensionOrder number(19,0) not null,
        image number(19,0) not null,
        pixelsType number(19,0) not null,
        relatedTo number(19,0),
        image_index number(10,0) not null,
        primary key (id),
        unique (image, image_index) deferrable initially deferred,
        check (significantBits > 0 and sizeX > 0 and sizeY > 0 and sizeZ > 0 and sizeC > 0 and sizeT > 0)
    );

    create table pixelsannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table pixelsoriginalfilemap (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table pixelstype (
        id number(19,0) not null,
        bitSize number(10,0),
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table planeinfo (
        id number(19,0) not null,
        deltaT double precision,
        permissions number(19,0) not null,
        exposureTime double precision,
        positionX double precision,
        positionY double precision,
        positionZ double precision,
        theC number(10,0) not null,
        theT number(10,0) not null,
        theZ number(10,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        pixels number(19,0) not null,
        primary key (id),
        check (theZ >= 0 and theC >= 0 and theT >= 0)
    );

    create table planeinfoannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table planeslicingcontext (
        "constant" number(1,0) not null,
        lowerLimit number(10,0) not null,
        planePrevious number(10,0) not null,
        planeSelected number(10,0) not null,
        upperLimit number(10,0) not null,
        codomainmapcontext_id number(19,0) not null,
        primary key (codomainmapcontext_id)
    );

    create table plate (
        id number(19,0) not null,
        columnNamingConvention varchar2(255 char),
        columns number(10,0),
        defaultSample number(10,0),
        description varchar2(255 char),
        permissions number(19,0) not null,
        externalIdentifier varchar2(255 char),
        name varchar2(255 char) not null,
        rowNamingConvention varchar2(255 char),
        "rows" number(10,0),
        status varchar2(255 char),
        version number(10,0),
        wellOriginX double precision,
        wellOriginY double precision,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table plateacquisition (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        endTime timestamp,
        maximumFieldCount number(10,0),
        name varchar2(255 char),
        startTime timestamp,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        plate number(19,0) not null,
        primary key (id)
    );

    create table plateacquisitionannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table plateannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table project (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        name varchar2(255 char) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table projectannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table projectdatasetlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table pulse (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table quantumdef (
        id number(19,0) not null,
        bitResolution number(10,0) not null,
        cdEnd number(10,0) not null,
        cdStart number(10,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table reagent (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        name varchar2(255 char),
        reagentIdentifier varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        screen number(19,0) not null,
        primary key (id)
    );

    create table reagentannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table renderingdef (
        id number(19,0) not null,
        compression double precision,
        defaultT number(10,0) not null,
        defaultZ number(10,0) not null,
        permissions number(19,0) not null,
        name varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        model number(19,0) not null,
        pixels number(19,0) not null,
        quantization number(19,0) not null,
        primary key (id)
    );

    create table renderingmodel (
        id number(19,0) not null,
        permissions number(19,0) not null,
        value varchar2(255 char) not null unique,
        external_id number(19,0) unique,
        primary key (id)
    );

    create table reverseintensitycontext (
        "reverse" number(1,0) not null,
        codomainmapcontext_id number(19,0) not null,
        primary key (codomainmapcontext_id)
    );

    create table roi (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        keywords STRING_ARRAY_ARRAY,
        namespaces STRING_ARRAY,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        image number(19,0),
        source number(19,0),
        primary key (id)
    );

    create table roiannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table screen (
        id number(19,0) not null,
        description varchar2(255 char),
        permissions number(19,0) not null,
        name varchar2(255 char) not null,
        protocolDescription varchar2(255 char),
        protocolIdentifier varchar2(255 char),
        reagentSetDescription varchar2(255 char),
        reagentSetIdentifier varchar2(255 char),
        type varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table screenannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table screenplatelink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table scriptjob (
        description varchar2(255 char),
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table session_ (
        id number(19,0) not null,
        closed timestamp,
        defaultEventType varchar2(255 char) not null,
        permissions number(19,0) not null,
        message varchar2(255 char),
        started timestamp not null,
        timeToIdle number(19,0) not null,
        timeToLive number(19,0) not null,
        userAgent varchar2(255 char),
        uuid varchar2(255 char) not null unique,
        version number(10,0),
        external_id number(19,0) unique,
        node number(19,0) not null,
        owner number(19,0) not null,
        primary key (id)
    );

    create table sessionannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table shape (
        discriminator varchar2(31 char) not null,
        id number(19,0) not null,
        permissions number(19,0) not null,
        fillColor number(10,0),
        fillRule varchar2(255 char),
        fontFamily varchar2(255 char),
        fontSize number(10,0),
        fontStretch varchar2(255 char),
        fontStyle varchar2(255 char),
        fontVariant varchar2(255 char),
        fontWeight varchar2(255 char),
        g varchar2(255 char),
        locked number(1,0),
        strokeColor number(10,0),
        strokeDashArray varchar2(255 char),
        strokeDashOffset number(10,0),
        strokeLineCap varchar2(255 char),
        strokeLineJoin varchar2(255 char),
        strokeMiterLimit number(10,0),
        strokeWidth number(10,0),
        theC number(10,0),
        theT number(10,0),
        theZ number(10,0),
        transform varchar2(255 char),
        vectorEffect varchar2(255 char),
        version number(10,0),
        visibility number(1,0),
        cx double precision,
        cy double precision,
        rx double precision,
        ry double precision,
        textValue varchar2(255 char),
        anchor varchar2(255 char),
        baselineShift varchar2(255 char),
        decoration varchar2(255 char),
        direction varchar2(255 char),
        glyphOrientationVertical number(10,0),
        writingMode varchar2(255 char),
        x double precision,
        y double precision,
        x1 double precision,
        x2 double precision,
        y1 double precision,
        y2 double precision,
        bytes BLOB,
        height double precision,
        width double precision,
        d varchar2(255 char),
        points varchar2(255 char),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        roi number(19,0) not null,
        pixels number(19,0),
        roi_index number(10,0) not null,
        primary key (id),
        unique (roi, roi_index) deferrable initially deferred
    );

    create table share_ (
        active number(1,0) not null,
        data BLOB not null,
        itemCount number(19,0) not null,
        session_id number(19,0) not null,
        "group" number(19,0) not null,
        primary key (session_id)
    );

    create table sharemember (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        external_id number(19,0) unique,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child) deferrable initially deferred
    );

    create table stagelabel (
        id number(19,0) not null,
        permissions number(19,0) not null,
        name varchar2(255 char) not null,
        positionX double precision,
        positionY double precision,
        positionZ double precision,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table statsinfo (
        id number(19,0) not null,
        permissions number(19,0) not null,
        globalMax double precision not null,
        globalMin double precision not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id)
    );

    create table thumbnail (
        id number(19,0) not null,
        permissions number(19,0) not null,
        mimeType varchar2(255 char) not null,
        "ref" varchar2(255 char),
        sizeX number(10,0) not null,
        sizeY number(10,0) not null,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        pixels number(19,0) not null,
        primary key (id)
    );

    create table thumbnailgenerationjob (
        job_id number(19,0) not null,
        primary key (job_id)
    );

    create table transmittancerange (
        id number(19,0) not null,
        cutIn number(10,0),
        cutInTolerance number(10,0),
        cutOut number(10,0),
        cutOutTolerance number(10,0),
        permissions number(19,0) not null,
        transmittance double precision,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        primary key (id),
        check (cutIn > 0 and cutOut > 0 and cutInTolerance >= 0 and cutOutTolerance >= 0 and transmittance >= 0 and transmittance <= 1)
    );

    create table uploadjob (
        job_id number(19,0) not null,
        versionInfo number(19,0),
        primary key (job_id)
    );

    create table well (
        id number(19,0) not null,
        alpha number(10,0),
        blue number(10,0),
        "column" number(10,0),
        permissions number(19,0) not null,
        externalDescription varchar2(255 char),
        externalIdentifier varchar2(255 char),
        green number(10,0),
        red number(10,0),
        "row" number(10,0),
        status varchar2(255 char),
        type varchar2(255 char),
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        plate number(19,0) not null,
        primary key (id)
    );

    create table wellannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table wellreagentlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    create table wellsample (
        id number(19,0) not null,
        permissions number(19,0) not null,
        posX double precision,
        posY double precision,
        timepoint timestamp,
        version number(10,0),
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        image number(19,0) not null,
        plateAcquisition number(19,0),
        well number(19,0) not null,
        well_index number(10,0) not null,
        primary key (id),
        unique (well, well_index) deferrable initially deferred
    );

    create table wellsampleannotationlink (
        id number(19,0) not null,
        permissions number(19,0) not null,
        version number(10,0),
        child number(19,0) not null,
        creation_id number(19,0) not null,
        external_id number(19,0) unique,
        group_id number(19,0) not null,
        owner_id number(19,0) not null,
        update_id number(19,0) not null,
        parent number(19,0) not null,
        primary key (id),
        unique (parent, child, owner_id) deferrable initially deferred
    );

    alter table acquisitionmode 
        add constraint FKacquisitionmode_external_14 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table annotation 
        add constraint FKann_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table annotation 
        add constraint FKann_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table annotation 
        add constraint FKann_external_id_externalinfo 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table annotation 
        add constraint FKfileann_file_originalfile 
        foreign key ("file") 
        references originalfile deferrable initially deferred ;

    alter table annotation 
        add constraint FKann_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table annotation 
        add constraint FKann_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table annotationannotationlink 
        add constraint FKannannlink_parent_ann 
        foreign key (parent) 
        references annotation deferrable initially deferred ;

    alter table arc 
        add constraint FKarc_lightsource_id_lights4 
        foreign key (lightsource_id) 
        references lightsource deferrable initially deferred ;

    alter table arc 
        add constraint FKarc_type_arctype 
        foreign key (type) 
        references arctype deferrable initially deferred ;

    alter table arctype 
        add constraint FKarctype_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table binning 
        add constraint FKbinning_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_logicalChannel_lo11 
        foreign key (logicalChannel) 
        references logicalchannel deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_statsInfo_statsinfo 
        foreign key (statsInfo) 
        references statsinfo deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_pixels_pixels 
        foreign key (pixels) 
        references pixels deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table channel 
        add constraint FKchannel_owner_id_experime3 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table channelannotationlink 
        add constraint FKchannelannlink_parent_cha3 
        foreign key (parent) 
        references channel deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_family_family 
        foreign key (family) 
        references family deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_renderingD14 
        foreign key (renderingDef) 
        references renderingdef deferrable initially deferred ;

    alter table channelbinding 
        add constraint FKchannelbinding_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table checksumalgorithm 
        add constraint FKchecksumalgorithm_externa16 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table codomainmapcontext 
        add constraint FKcodomainmapcontext_creati10 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table codomainmapcontext 
        add constraint FKcodomainmapcontext_update8 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table codomainmapcontext 
        add constraint FKcodomainmapcontext_extern17 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table codomainmapcontext 
        add constraint FKcodomainmapcontext_group_7 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table codomainmapcontext 
        add constraint FKcodomainmapcontext_render18 
        foreign key (renderingDef) 
        references renderingdef deferrable initially deferred ;

    alter table codomainmapcontext 
        add constraint FKcodomainmapcontext_owner_14 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table contrastmethod 
        add constraint FKcontrastmethod_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table contraststretchingcontext 
        add constraint FKcontraststretchingcontext40 
        foreign key (codomainmapcontext_id) 
        references codomainmapcontext deferrable initially deferred ;

    alter table correction 
        add constraint FKcorrection_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table count_Annotation_annotation13 
        add constraint FK_cnt__Ann_annLinks 
        foreign key (Annotation_id) 
        references annotation deferrable initially deferred ;

    alter table count_Channel_annotationLin10 
        add constraint FK_cnt__Channel_annLinks 
        foreign key (Channel_id) 
        references channel deferrable initially deferred ;

    alter table count_Dataset_annotationLin10 
        add constraint FK_cnt__Dataset_annLinks 
        foreign key (Dataset_id) 
        references dataset deferrable initially deferred ;

    alter table count_Dataset_imageLinks_by5 
        add constraint FK_cnt__Dataset_imageLinks 
        foreign key (Dataset_id) 
        references dataset deferrable initially deferred ;

    alter table count_Dataset_projectLinks_7 
        add constraint FK_cnt__Dataset_projectLinks 
        foreign key (Dataset_id) 
        references dataset deferrable initially deferred ;

    alter table count_ExperimenterGroup_ann20 
        add constraint FK_cnt__Group_annLinks 
        foreign key (ExperimenterGroup_id) 
        references experimentergroup deferrable initially deferred ;

    alter table count_Experimenter_annotati15 
        add constraint FK_cnt__Experimenter_annLinks 
        foreign key (Experimenter_id) 
        references experimenter deferrable initially deferred ;

    alter table count_Fileset_annotationLin10 
        add constraint FK_cnt__Fileset_annLinks 
        foreign key (Fileset_id) 
        references fileset deferrable initially deferred ;

    alter table count_Fileset_jobLinks_by_o3 
        add constraint FK_cnt__Fileset_jobLinks 
        foreign key (Fileset_id) 
        references fileset deferrable initially deferred ;

    alter table count_FilterSet_emissionFil15 
        add constraint FK_cnt__FilterSet_emissionF8 
        foreign key (FilterSet_id) 
        references filterset deferrable initially deferred ;

    alter table count_FilterSet_excitationF17 
        add constraint FK_cnt__FilterSet_excitatio10 
        foreign key (FilterSet_id) 
        references filterset deferrable initially deferred ;

    alter table count_Filter_emissionFilter12 
        add constraint FK_cnt__Filter_emissionFilt5 
        foreign key (Filter_id) 
        references filter deferrable initially deferred ;

    alter table count_Filter_excitationFilt14 
        add constraint FK_cnt__Filter_excitationFi7 
        foreign key (Filter_id) 
        references filter deferrable initially deferred ;

    alter table count_Image_annotationLinks8 
        add constraint FK_cnt__Image_annLinks 
        foreign key (Image_id) 
        references image deferrable initially deferred ;

    alter table count_Image_datasetLinks_by5 
        add constraint FK_cnt__Image_datasetLinks 
        foreign key (Image_id) 
        references image deferrable initially deferred ;

    alter table count_Job_originalFileLinks8 
        add constraint FK_cnt__Job_originalFileLinks 
        foreign key (Job_id) 
        references job deferrable initially deferred ;

    alter table count_LightPath_emissionFil15 
        add constraint FK_cnt__LightPath_emissionF8 
        foreign key (LightPath_id) 
        references lightpath deferrable initially deferred ;

    alter table count_LightPath_excitationF17 
        add constraint FK_cnt__LightPath_excitatio10 
        foreign key (LightPath_id) 
        references lightpath deferrable initially deferred ;

    alter table count_Namespace_annotationL12 
        add constraint FK_cnt__Namespace_annLinks 
        foreign key (Namespace_id) 
        references namespace deferrable initially deferred ;

    alter table count_Node_annotationLinks_7 
        add constraint FK_cnt__Node_annLinks 
        foreign key (Node_id) 
        references node deferrable initially deferred ;

    alter table count_OriginalFile_annotati15 
        add constraint FK_cnt__OriginalFile_annLinks 
        foreign key (OriginalFile_id) 
        references originalfile deferrable initially deferred ;

    alter table count_OriginalFile_pixelsFi14 
        add constraint FK_cnt__OriginalFile_pixels7 
        foreign key (OriginalFile_id) 
        references originalfile deferrable initially deferred ;

    alter table count_Pixels_annotationLink9 
        add constraint FK_cnt__Pixels_annLinks 
        foreign key (Pixels_id) 
        references pixels deferrable initially deferred ;

    alter table count_Pixels_pixelsFileMaps8 
        add constraint FK_cnt__Pixels_pixelsFileMaps 
        foreign key (Pixels_id) 
        references pixels deferrable initially deferred ;

    alter table count_PlaneInfo_annotationL12 
        add constraint FK_cnt__PlaneInfo_annLinks 
        foreign key (PlaneInfo_id) 
        references planeinfo deferrable initially deferred ;

    alter table count_PlateAcquisition_anno19 
        add constraint FK_cnt__PlateAcquisition_an5 
        foreign key (PlateAcquisition_id) 
        references plateacquisition deferrable initially deferred ;

    alter table count_Plate_annotationLinks8 
        add constraint FK_cnt__Plate_annLinks 
        foreign key (Plate_id) 
        references plate deferrable initially deferred ;

    alter table count_Plate_screenLinks_by_4 
        add constraint FK_cnt__Plate_screenLinks 
        foreign key (Plate_id) 
        references plate deferrable initially deferred ;

    alter table count_Project_annotationLin10 
        add constraint FK_cnt__Project_annLinks 
        foreign key (Project_id) 
        references project deferrable initially deferred ;

    alter table count_Project_datasetLinks_7 
        add constraint FK_cnt__Project_datasetLinks 
        foreign key (Project_id) 
        references project deferrable initially deferred ;

    alter table count_Reagent_annotationLin10 
        add constraint FK_cnt__Reagent_annLinks 
        foreign key (Reagent_id) 
        references reagent deferrable initially deferred ;

    alter table count_Reagent_wellLinks_by_4 
        add constraint FK_cnt__Reagent_wellLinks 
        foreign key (Reagent_id) 
        references reagent deferrable initially deferred ;

    alter table count_Roi_annotationLinks_b6 
        add constraint FK_cnt__Roi_annLinks 
        foreign key (Roi_id) 
        references roi deferrable initially deferred ;

    alter table count_Screen_annotationLink9 
        add constraint FK_cnt__Screen_annLinks 
        foreign key (Screen_id) 
        references screen deferrable initially deferred ;

    alter table count_Screen_plateLinks_by_4 
        add constraint FK_cnt__Screen_plateLinks 
        foreign key (Screen_id) 
        references screen deferrable initially deferred ;

    alter table count_Session_annotationLin10 
        add constraint FK_cnt__Session_annLinks 
        foreign key (Session_id) 
        references session_ deferrable initially deferred ;

    alter table count_WellSample_annotation13 
        add constraint FK_cnt__WellSample_annLinks 
        foreign key (WellSample_id) 
        references wellsample deferrable initially deferred ;

    alter table count_Well_annotationLinks_7 
        add constraint FK_cnt__Well_annLinks 
        foreign key (Well_id) 
        references well deferrable initially deferred ;

    alter table count_Well_reagentLinks_by_4 
        add constraint FK_cnt__Well_reagentLinks 
        foreign key (Well_id) 
        references well deferrable initially deferred ;

    alter table dataset 
        add constraint FKdataset_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table dataset 
        add constraint FKdataset_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table dataset 
        add constraint FKdataset_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table dataset 
        add constraint FKdataset_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table dataset 
        add constraint FKdataset_owner_id_experime3 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table datasetannotationlink 
        add constraint FKdatasetannlink_parent_dat3 
        foreign key (parent) 
        references dataset deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_creation8 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_child_image 
        foreign key (child) 
        references image deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_update_i6 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_external15 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_group_id5 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_owner_id12 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table datasetimagelink 
        add constraint FKdatasetimagelink_parent_d5 
        foreign key (parent) 
        references dataset deferrable initially deferred ;

    alter table dbpatch 
        add constraint FKdbpatch_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_external_id_exte7 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_type_detectortype 
        foreign key (type) 
        references detectortype deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_instrument_instr4 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table detector 
        add constraint FKdetector_owner_id_experim4 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_creation8 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_update_i6 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_external15 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_binning_6 
        foreign key (binning) 
        references binning deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_group_id5 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_detector8 
        foreign key (detector) 
        references detector deferrable initially deferred ;

    alter table detectorsettings 
        add constraint FKdetectorsettings_owner_id12 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table detectortype 
        add constraint FKdetectortype_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table dichroic 
        add constraint FKdichroic_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table dichroic 
        add constraint FKdichroic_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table dichroic 
        add constraint FKdichroic_external_id_exte7 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table dichroic 
        add constraint FKdichroic_instrument_instr4 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table dichroic 
        add constraint FKdichroic_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table dichroic 
        add constraint FKdichroic_owner_id_experim4 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table dimensionorder 
        add constraint FKdimensionorder_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table event 
        add constraint FKevent_experimenterGroup_g3 
        foreign key (experimenterGroup) 
        references experimentergroup deferrable initially deferred ;

    alter table event 
        add constraint FKevent_external_id_externa4 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table event 
        add constraint FKevent_session_session 
        foreign key ("session") 
        references session_ deferrable initially deferred ;

    alter table event 
        add constraint FKevent_containingEvent_event 
        foreign key (containingEvent) 
        references event deferrable initially deferred ;

    alter table event 
        add constraint FKevent_type_eventtype 
        foreign key (type) 
        references eventtype deferrable initially deferred ;

    alter table event 
        add constraint FKevent_experimenter_experi5 
        foreign key (experimenter) 
        references experimenter deferrable initially deferred ;

    alter table eventlog 
        add constraint FKeventlog_external_id_exte7 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table eventlog 
        add constraint FKeventlog_event_event 
        foreign key (event) 
        references event deferrable initially deferred ;

    alter table eventtype 
        add constraint FKeventtype_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table experiment 
        add constraint FKexperiment_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table experiment 
        add constraint FKexperiment_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table experiment 
        add constraint FKexperiment_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table experiment 
        add constraint FKexperiment_type_experimen4 
        foreign key (type) 
        references experimenttype deferrable initially deferred ;

    alter table experiment 
        add constraint FKexperiment_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table experiment 
        add constraint FKexperiment_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table experimenter 
        add constraint FKexperimenter_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_creat11 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_child3 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_updat9 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_exter18 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_group8 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_owner15 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table experimenterannotationlink 
        add constraint FKexperimenterannlink_paren13 
        foreign key (parent) 
        references experimenter deferrable initially deferred ;

    alter table experimentergroup 
        add constraint FKgroup_external_id_externa4 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table experimentergroupannotation3 
        add constraint FKgroupannlink_parent_group 
        foreign key (parent) 
        references experimentergroup deferrable initially deferred ;

    alter table experimenttype 
        add constraint FKexperimenttype_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table externalinfo 
        add constraint FKexternalinfo_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table externalinfo 
        add constraint FKexternalinfo_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table externalinfo 
        add constraint FKexternalinfo_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table externalinfo 
        add constraint FKexternalinfo_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table family 
        add constraint FKfamily_external_id_extern5 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filament 
        add constraint FKfilament_lightsource_id_l9 
        foreign key (lightsource_id) 
        references lightsource deferrable initially deferred ;

    alter table filament 
        add constraint FKfilament_type_filamenttype 
        foreign key (type) 
        references filamenttype deferrable initially deferred ;

    alter table filamenttype 
        add constraint FKfilamenttype_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table fileset 
        add constraint FKfileset_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table fileset 
        add constraint FKfileset_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table fileset 
        add constraint FKfileset_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table fileset 
        add constraint FKfileset_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table fileset 
        add constraint FKfileset_owner_id_experime3 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filesetannotationlink 
        add constraint FKfilesetannlink_parent_fil3 
        foreign key (parent) 
        references fileset deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_originalFile12 
        foreign key (originalFile) 
        references originalfile deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_fileset_fileset 
        foreign key (fileset) 
        references fileset deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filesetentry 
        add constraint FKfilesetentry_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_child_job 
        foreign key (child) 
        references job deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filesetjoblink 
        add constraint FKfilesetjoblink_parent_fil3 
        foreign key (parent) 
        references fileset deferrable initially deferred ;

    alter table filesetversioninfo 
        add constraint FKfilesetversioninfo_creati10 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filesetversioninfo 
        add constraint FKfilesetversioninfo_update8 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filesetversioninfo 
        add constraint FKfilesetversioninfo_extern17 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filesetversioninfo 
        add constraint FKfilesetversioninfo_group_7 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filesetversioninfo 
        add constraint FKfilesetversioninfo_owner_14 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_external_id_extern5 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_transmittanceRange18 
        foreign key (transmittanceRange) 
        references transmittancerange deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_type_filtertype 
        foreign key (type) 
        references filtertype deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_instrument_instrument 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filter 
        add constraint FKfilter_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_instrument_inst5 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_dichroic_dichroic 
        foreign key (dichroic) 
        references dichroic deferrable initially deferred ;

    alter table filterset 
        add constraint FKfilterset_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli19 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli14 
        foreign key (child) 
        references filter deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli17 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli26 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli16 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli23 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filtersetemissionfilterlink 
        add constraint FKfiltersetemissionfilterli18 
        foreign key (parent) 
        references filterset deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter21 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter16 
        foreign key (child) 
        references filter deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter19 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter28 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter18 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter25 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table filtersetexcitationfilterlink 
        add constraint FKfiltersetexcitationfilter20 
        foreign key (parent) 
        references filterset deferrable initially deferred ;

    alter table filtertype 
        add constraint FKfiltertype_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table format 
        add constraint FKformat_external_id_extern5 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table groupexperimentermap 
        add constraint FKgroupexperimentermap_chil13 
        foreign key (child) 
        references experimenter deferrable initially deferred ;

    alter table groupexperimentermap 
        add constraint FKgroupexperimentermap_exte19 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table groupexperimentermap 
        add constraint FKgroupexperimentermap_pare7 
        foreign key (parent) 
        references experimentergroup deferrable initially deferred ;

    alter table illumination 
        add constraint FKillumination_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table image 
        add constraint FKimage_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table image 
        add constraint FKimage_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table image 
        add constraint FKimage_external_id_externa4 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table image 
        add constraint FKimage_imagingEnvironment_17 
        foreign key (imagingEnvironment) 
        references imagingenvironment deferrable initially deferred ;

    alter table image 
        add constraint FKimage_experiment_experiment 
        foreign key (experiment) 
        references experiment deferrable initially deferred ;

    alter table image 
        add constraint FKimage_instrument_instrument 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table image 
        add constraint FKimage_format_format 
        foreign key (format) 
        references format deferrable initially deferred ;

    alter table image 
        add constraint FKimage_fileset_fileset 
        foreign key (fileset) 
        references fileset deferrable initially deferred ;

    alter table image 
        add constraint FKimage_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table image 
        add constraint FKimage_stageLabel_stagelabel 
        foreign key (stageLabel) 
        references stagelabel deferrable initially deferred ;

    alter table image 
        add constraint FKimage_objectiveSettings_o15 
        foreign key (objectiveSettings) 
        references objectivesettings deferrable initially deferred ;

    alter table image 
        add constraint FKimage_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table imageannotationlink 
        add constraint FKimageannlink_parent_image 
        foreign key (parent) 
        references image deferrable initially deferred ;

    alter table imagingenvironment 
        add constraint FKimagingenvironment_creati10 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table imagingenvironment 
        add constraint FKimagingenvironment_update8 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table imagingenvironment 
        add constraint FKimagingenvironment_extern17 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table imagingenvironment 
        add constraint FKimagingenvironment_group_7 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table imagingenvironment 
        add constraint FKimagingenvironment_owner_14 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table immersion 
        add constraint FKimmersion_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table importjob 
        add constraint FKimportjob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table indexingjob 
        add constraint FKindexingjob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table instrument 
        add constraint FKinstrument_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table instrument 
        add constraint FKinstrument_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table instrument 
        add constraint FKinstrument_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table instrument 
        add constraint FKinstrument_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table instrument 
        add constraint FKinstrument_microscope_mic6 
        foreign key (microscope) 
        references microscope deferrable initially deferred ;

    alter table instrument 
        add constraint FKinstrument_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table integritycheckjob 
        add constraint FKintegritycheckjob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table job 
        add constraint FKjob_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table job 
        add constraint FKjob_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table job 
        add constraint FKjob_external_id_externalinfo 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table job 
        add constraint FKjob_status_jobstatus 
        foreign key (status) 
        references jobstatus deferrable initially deferred ;

    alter table job 
        add constraint FKjob_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table job 
        add constraint FKjob_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_creat11 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_child12 
        foreign key (child) 
        references originalfile deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_updat9 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_exter18 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_group8 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_owner15 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table joboriginalfilelink 
        add constraint FKjoboriginalfilelink_paren4 
        foreign key (parent) 
        references job deferrable initially deferred ;

    alter table jobstatus 
        add constraint FKjobstatus_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table laser 
        add constraint FKlaser_lightsource_id_ligh6 
        foreign key (lightsource_id) 
        references lightsource deferrable initially deferred ;

    alter table laser 
        add constraint FKlaser_pump_lightsource 
        foreign key (pump) 
        references lightsource deferrable initially deferred ;

    alter table laser 
        add constraint FKlaser_laserMedium_laserme3 
        foreign key (laserMedium) 
        references lasermedium deferrable initially deferred ;

    alter table laser 
        add constraint FKlaser_pulse_pulse 
        foreign key (pulse) 
        references pulse deferrable initially deferred ;

    alter table laser 
        add constraint FKlaser_type_lasertype 
        foreign key (type) 
        references lasertype deferrable initially deferred ;

    alter table lasermedium 
        add constraint FKlasermedium_external_id_e10 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lasertype 
        add constraint FKlasertype_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lightemittingdiode 
        add constraint FKlightemittingdiode_lights19 
        foreign key (lightsource_id) 
        references lightsource deferrable initially deferred ;

    alter table lightpath 
        add constraint FKlightpath_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table lightpath 
        add constraint FKlightpath_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table lightpath 
        add constraint FKlightpath_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lightpath 
        add constraint FKlightpath_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table lightpath 
        add constraint FKlightpath_dichroic_dichroic 
        foreign key (dichroic) 
        references dichroic deferrable initially deferred ;

    alter table lightpath 
        add constraint FKlightpath_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli19 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli14 
        foreign key (child) 
        references filter deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli17 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli26 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli16 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli23 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table lightpathemissionfilterlink 
        add constraint FKlightpathemissionfilterli18 
        foreign key (parent) 
        references lightpath deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter21 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter16 
        foreign key (child) 
        references filter deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter19 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter28 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter18 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter25 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table lightpathexcitationfilterlink 
        add constraint FKlightpathexcitationfilter20 
        foreign key (parent) 
        references lightpath deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_creation_id5 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_update_id_e3 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_external_id12 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_lightSource11 
        foreign key (lightSource) 
        references lightsource deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_microbeamMa31 
        foreign key (microbeamManipulation) 
        references microbeammanipulation deferrable initially deferred ;

    alter table lightsettings 
        add constraint FKlightsettings_owner_id_ex9 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table lightsource 
        add constraint FKlightsource_creation_id_e3 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table lightsource 
        add constraint FKlightsource_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table lightsource 
        add constraint FKlightsource_external_id_e10 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table lightsource 
        add constraint FKlightsource_instrument_in7 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table lightsource 
        add constraint FKlightsource_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table lightsource 
        add constraint FKlightsource_owner_id_expe7 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table link 
        add constraint FKlink_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table link 
        add constraint FKlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table link 
        add constraint FKlink_external_id_external3 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table link 
        add constraint FKlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table link 
        add constraint FKlink_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_photometri40 
        foreign key (photometricInterpretation) 
        references photometricinterpretation deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_lightPath_8 
        foreign key (lightPath) 
        references lightpath deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_mode_acqui9 
        foreign key ("mode") 
        references acquisitionmode deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_otf_otf 
        foreign key (otf) 
        references otf deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_lightSourc22 
        foreign key (lightSourceSettings) 
        references lightsettings deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_filterSet_8 
        foreign key (filterSet) 
        references filterset deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_detectorSe22 
        foreign key (detectorSettings) 
        references detectorsettings deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_contrastMe18 
        foreign key (contrastMethod) 
        references contrastmethod deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table logicalchannel 
        add constraint FKlogicalchannel_illuminati14 
        foreign key (illumination) 
        references illumination deferrable initially deferred ;

    alter table medium 
        add constraint FKmedium_external_id_extern5 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table metadataimportjob 
        add constraint FKmetadataimportjob_version22 
        foreign key (versionInfo) 
        references filesetversioninfo deferrable initially deferred ;

    alter table metadataimportjob 
        add constraint FKmetadataimportjob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_cre13 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_upd11 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_ext20 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_exp17 
        foreign key (experiment) 
        references experiment deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_typ26 
        foreign key (type) 
        references microbeammanipulationtype deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_gro10 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table microbeammanipulation 
        add constraint FKmicrobeammanipulation_own17 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table microbeammanipulationtype 
        add constraint FKmicrobeammanipulationtype24 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table microscope 
        add constraint FKmicroscope_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table microscope 
        add constraint FKmicroscope_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table microscope 
        add constraint FKmicroscope_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table microscope 
        add constraint FKmicroscope_type_microscop4 
        foreign key (type) 
        references microscopetype deferrable initially deferred ;

    alter table microscope 
        add constraint FKmicroscope_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table microscope 
        add constraint FKmicroscope_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table microscopetype 
        add constraint FKmicroscopetype_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table namespace 
        add constraint FKnamespace_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table namespace 
        add constraint FKnamespace_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table namespace 
        add constraint FKnamespace_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table namespace 
        add constraint FKnamespace_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table namespace 
        add constraint FKnamespace_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_creation8 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_update_i6 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_external15 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_group_id5 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_owner_id12 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table namespaceannotationlink 
        add constraint FKnamespaceannlink_parent_n7 
        foreign key (parent) 
        references namespace deferrable initially deferred ;

    alter table node 
        add constraint FKnode_external_id_external3 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_creation_id_e3 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_external_id_e10 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_owner_id_expe7 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table nodeannotationlink 
        add constraint FKnodeannlink_parent_node 
        foreign key (parent) 
        references node deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_immersion_immer3 
        foreign key (immersion) 
        references immersion deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_instrument_inst5 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_correction_corr5 
        foreign key (correction) 
        references correction deferrable initially deferred ;

    alter table objective 
        add constraint FKobjective_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_creatio9 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_medium_5 
        foreign key (medium) 
        references medium deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_update_7 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_externa16 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_objecti11 
        foreign key (objective) 
        references objective deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_group_i6 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table objectivesettings 
        add constraint FKobjectivesettings_owner_i13 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table originalfile 
        add constraint FKoriginalfile_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table originalfile 
        add constraint FKoriginalfile_hasher_check11 
        foreign key (hasher) 
        references checksumalgorithm deferrable initially deferred ;

    alter table originalfile 
        add constraint FKoriginalfile_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table originalfile 
        add constraint FKoriginalfile_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table originalfile 
        add constraint FKoriginalfile_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table originalfile 
        add constraint FKoriginalfile_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_creat11 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_child3 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_updat9 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_exter18 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_group8 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_owner15 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table originalfileannotationlink 
        add constraint FKoriginalfileannlink_paren13 
        foreign key (parent) 
        references originalfile deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_filterSet_filterset 
        foreign key (filterSet) 
        references filterset deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_external_id_externalinfo 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_objective_objective 
        foreign key (objective) 
        references objective deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_instrument_instrument 
        foreign key (instrument) 
        references instrument deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_pixelsType_pixelstype 
        foreign key (pixelsType) 
        references pixelstype deferrable initially deferred ;

    alter table otf 
        add constraint FKotf_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table parsejob 
        add constraint FKparsejob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table photometricinterpretation 
        add constraint FKphotometricinterpretation24 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table pixeldatajob 
        add constraint FKpixeldatajob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_external_id_extern5 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_dimensionOrder_dim10 
        foreign key (dimensionOrder) 
        references dimensionorder deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_relatedTo_pixels 
        foreign key (relatedTo) 
        references pixels deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_image_image 
        foreign key (image) 
        references image deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_pixelsType_pixelstype 
        foreign key (pixelsType) 
        references pixelstype deferrable initially deferred ;

    alter table pixels 
        add constraint FKpixels_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_creation_id5 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_update_id_e3 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_external_id12 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_owner_id_ex9 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table pixelsannotationlink 
        add constraint FKpixelsannlink_parent_pixels 
        foreign key (parent) 
        references pixels deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_cre13 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_chi8 
        foreign key (child) 
        references pixels deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_upd11 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_ext20 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_gro10 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_own17 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table pixelsoriginalfilemap 
        add constraint FKpixelsoriginalfilemap_par15 
        foreign key (parent) 
        references originalfile deferrable initially deferred ;

    alter table pixelstype 
        add constraint FKpixelstype_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table planeinfo 
        add constraint FKplaneinfo_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table planeinfo 
        add constraint FKplaneinfo_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table planeinfo 
        add constraint FKplaneinfo_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table planeinfo 
        add constraint FKplaneinfo_pixels_pixels 
        foreign key (pixels) 
        references pixels deferrable initially deferred ;

    alter table planeinfo 
        add constraint FKplaneinfo_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table planeinfo 
        add constraint FKplaneinfo_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_creation8 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_update_i6 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_external15 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_group_id5 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_owner_id12 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table planeinfoannotationlink 
        add constraint FKplaneinfoannlink_parent_p7 
        foreign key (parent) 
        references planeinfo deferrable initially deferred ;

    alter table planeslicingcontext 
        add constraint FKplaneslicingcontext_codom34 
        foreign key (codomainmapcontext_id) 
        references codomainmapcontext deferrable initially deferred ;

    alter table plate 
        add constraint FKplate_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table plate 
        add constraint FKplate_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table plate 
        add constraint FKplate_external_id_externa4 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table plate 
        add constraint FKplate_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table plate 
        add constraint FKplate_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table plateacquisition 
        add constraint FKplateacquisition_creation8 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table plateacquisition 
        add constraint FKplateacquisition_update_i6 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table plateacquisition 
        add constraint FKplateacquisition_external15 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table plateacquisition 
        add constraint FKplateacquisition_plate_plate 
        foreign key (plate) 
        references plate deferrable initially deferred ;

    alter table plateacquisition 
        add constraint FKplateacquisition_group_id5 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table plateacquisition 
        add constraint FKplateacquisition_owner_id12 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_c15 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_c7 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_u13 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_e22 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_g12 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_o19 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table plateacquisitionannotationlink 
        add constraint FKplateacquisitionannlink_p21 
        foreign key (parent) 
        references plateacquisition deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table plateannotationlink 
        add constraint FKplateannlink_parent_plate 
        foreign key (parent) 
        references plate deferrable initially deferred ;

    alter table project 
        add constraint FKproject_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table project 
        add constraint FKproject_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table project 
        add constraint FKproject_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table project 
        add constraint FKproject_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table project 
        add constraint FKproject_owner_id_experime3 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table projectannotationlink 
        add constraint FKprojectannlink_parent_pro3 
        foreign key (parent) 
        references project deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_creati10 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_child_6 
        foreign key (child) 
        references dataset deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_update8 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_extern17 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_group_7 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_owner_14 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table projectdatasetlink 
        add constraint FKprojectdatasetlink_parent7 
        foreign key (parent) 
        references project deferrable initially deferred ;

    alter table pulse 
        add constraint FKpulse_external_id_externa4 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table quantumdef 
        add constraint FKquantumdef_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table quantumdef 
        add constraint FKquantumdef_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table quantumdef 
        add constraint FKquantumdef_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table quantumdef 
        add constraint FKquantumdef_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table quantumdef 
        add constraint FKquantumdef_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table reagent 
        add constraint FKreagent_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table reagent 
        add constraint FKreagent_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table reagent 
        add constraint FKreagent_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table reagent 
        add constraint FKreagent_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table reagent 
        add constraint FKreagent_screen_screen 
        foreign key (screen) 
        references screen deferrable initially deferred ;

    alter table reagent 
        add constraint FKreagent_owner_id_experime3 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table reagentannotationlink 
        add constraint FKreagentannlink_parent_rea3 
        foreign key (parent) 
        references reagent deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_creation_id_4 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_quantization10 
        foreign key (quantization) 
        references quantumdef deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_external_id_11 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_model_render7 
        foreign key (model) 
        references renderingmodel deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_pixels_pixels 
        foreign key (pixels) 
        references pixels deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table renderingdef 
        add constraint FKrenderingdef_owner_id_exp8 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table renderingmodel 
        add constraint FKrenderingmodel_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table reverseintensitycontext 
        add constraint FKreverseintensitycontext_c38 
        foreign key (codomainmapcontext_id) 
        references codomainmapcontext deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_external_id_externalinfo 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_source_originalfile 
        foreign key (source) 
        references originalfile deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_image_image 
        foreign key (image) 
        references image deferrable initially deferred ;

    alter table roi 
        add constraint FKroi_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table roiannotationlink 
        add constraint FKroiannlink_parent_roi 
        foreign key (parent) 
        references roi deferrable initially deferred ;

    alter table screen 
        add constraint FKscreen_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table screen 
        add constraint FKscreen_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table screen 
        add constraint FKscreen_external_id_extern5 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table screen 
        add constraint FKscreen_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table screen 
        add constraint FKscreen_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_creation_id5 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_update_id_e3 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_external_id12 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_owner_id_ex9 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table screenannotationlink 
        add constraint FKscreenannlink_parent_screen 
        foreign key (parent) 
        references screen deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_creation_7 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_child_plate 
        foreign key (child) 
        references plate deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_update_id5 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_external_14 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_group_id_4 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_owner_id_11 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table screenplatelink 
        add constraint FKscreenplatelink_parent_sc3 
        foreign key (parent) 
        references screen deferrable initially deferred ;

    alter table scriptjob 
        add constraint FKscriptjob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table session_ 
        add constraint FKsession_node_node 
        foreign key (node) 
        references node deferrable initially deferred ;

    alter table session_ 
        add constraint FKsession_external_id_exter6 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table session_ 
        add constraint FKsession_owner_experimenter 
        foreign key (owner) 
        references experimenter deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_creation_i6 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_update_id_4 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_external_i13 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_group_id_g3 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_owner_id_e10 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table sessionannotationlink 
        add constraint FKsessionannlink_parent_ses3 
        foreign key (parent) 
        references session_ deferrable initially deferred ;

    alter table shape 
        add constraint FKshape_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table shape 
        add constraint FKshape_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table shape 
        add constraint FKshape_external_id_externa4 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table shape 
        add constraint FKmask_pixels_pixels 
        foreign key (pixels) 
        references pixels deferrable initially deferred ;

    alter table shape 
        add constraint FKshape_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table shape 
        add constraint FKshape_roi_roi 
        foreign key (roi) 
        references roi deferrable initially deferred ;

    alter table shape 
        add constraint FKshape_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table share_ 
        add constraint FKshare_group_group 
        foreign key ("group") 
        references experimentergroup deferrable initially deferred ;

    alter table share_ 
        add constraint FKshare_session_id_session 
        foreign key (session_id) 
        references session_ deferrable initially deferred ;

    alter table sharemember 
        add constraint FKsharemember_child_experim4 
        foreign key (child) 
        references experimenter deferrable initially deferred ;

    alter table sharemember 
        add constraint FKsharemember_external_id_e10 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table sharemember 
        add constraint FKsharemember_parent_share 
        foreign key (parent) 
        references share_ deferrable initially deferred ;

    alter table stagelabel 
        add constraint FKstagelabel_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table stagelabel 
        add constraint FKstagelabel_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table stagelabel 
        add constraint FKstagelabel_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table stagelabel 
        add constraint FKstagelabel_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table stagelabel 
        add constraint FKstagelabel_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table statsinfo 
        add constraint FKstatsinfo_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table statsinfo 
        add constraint FKstatsinfo_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table statsinfo 
        add constraint FKstatsinfo_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table statsinfo 
        add constraint FKstatsinfo_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table statsinfo 
        add constraint FKstatsinfo_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table thumbnail 
        add constraint FKthumbnail_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table thumbnail 
        add constraint FKthumbnail_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table thumbnail 
        add constraint FKthumbnail_external_id_ext8 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table thumbnail 
        add constraint FKthumbnail_pixels_pixels 
        foreign key (pixels) 
        references pixels deferrable initially deferred ;

    alter table thumbnail 
        add constraint FKthumbnail_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table thumbnail 
        add constraint FKthumbnail_owner_id_experi5 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table thumbnailgenerationjob 
        add constraint FKthumbnailgenerationjob_jo7 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table transmittancerange 
        add constraint FKtransmittancerange_creati10 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table transmittancerange 
        add constraint FKtransmittancerange_update8 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table transmittancerange 
        add constraint FKtransmittancerange_extern17 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table transmittancerange 
        add constraint FKtransmittancerange_group_7 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table transmittancerange 
        add constraint FKtransmittancerange_owner_14 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table uploadjob 
        add constraint FKuploadjob_versionInfo_fil14 
        foreign key (versionInfo) 
        references filesetversioninfo deferrable initially deferred ;

    alter table uploadjob 
        add constraint FKuploadjob_job_id_job 
        foreign key (job_id) 
        references job deferrable initially deferred ;

    alter table well 
        add constraint FKwell_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table well 
        add constraint FKwell_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table well 
        add constraint FKwell_external_id_external3 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table well 
        add constraint FKwell_plate_plate 
        foreign key (plate) 
        references plate deferrable initially deferred ;

    alter table well 
        add constraint FKwell_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table well 
        add constraint FKwell_owner_id_experimenter 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_creation_id_e3 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_external_id_e10 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_owner_id_expe7 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table wellannotationlink 
        add constraint FKwellannlink_parent_well 
        foreign key (parent) 
        references well deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_creation_7 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_child_rea3 
        foreign key (child) 
        references reagent deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_update_id5 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_external_14 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_group_id_4 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_owner_id_11 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table wellreagentlink 
        add constraint FKwellreagentlink_parent_well 
        foreign key (parent) 
        references well deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_creation_id_event 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_plateAcquisiti18 
        foreign key (plateAcquisition) 
        references plateacquisition deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_update_id_event 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_external_id_ex9 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_well_well 
        foreign key (well) 
        references well deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_group_id_group 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_image_image 
        foreign key (image) 
        references image deferrable initially deferred ;

    alter table wellsample 
        add constraint FKwellsample_owner_id_exper6 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_creatio9 
        foreign key (creation_id) 
        references event deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_child_ann 
        foreign key (child) 
        references annotation deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_update_7 
        foreign key (update_id) 
        references event deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_externa16 
        foreign key (external_id) 
        references externalinfo deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_group_i6 
        foreign key (group_id) 
        references experimentergroup deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_owner_i13 
        foreign key (owner_id) 
        references experimenter deferrable initially deferred ;

    alter table wellsampleannotationlink 
        add constraint FKwellsampleannlink_parent_9 
        foreign key (parent) 
        references wellsample deferrable initially deferred ;

    create table seq_table (
         sequence_name varchar2(255 char) not null ,
         next_val number(19,0),
        primary key ( sequence_name ) 
    ) ;
