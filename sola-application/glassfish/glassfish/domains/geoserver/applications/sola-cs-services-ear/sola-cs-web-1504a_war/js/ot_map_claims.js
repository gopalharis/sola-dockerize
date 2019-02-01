var MSG = MSG || {};
MSG.ERR = MSG.ERR || {};
MSG.ERR.MAP_CONTROL_ADDITIONAL_LOCATION_DESCRIPTION_REQUIRED = "Provide a description to additional location";
MSG.ERR.MAP_CONTROL_BAD_FEATURE_STRUCTURE = "Bad feature structure";
MSG.ERR.MAP_CONTROL_CLAIM_GEOMETRY_REQUIERD = "Claim geometry must be provided";
MSG.ERR.MAP_CONTROL_CLAIM_GEOMETRY_MUST_BE_ONE = "Claim geometry must be only one, not multiple";
MSG.ERR.MAP_CONTROL_CLAIM_ADDITIONAL_LOCATION_DESCRIPTION_REQUIRED = "Additional location description required";

var additionalLocationFeature;
var mapControlId;

function showAdditionalLocationDialog(feature) {
    if (feature === null || typeof feature === 'undefined'
            || typeof feature.attributes === 'undefined') {
        alert(MSG.ERR.MAP_CONTROL_BAD_FEATURE_STRUCTURE);
        return;
    }

    additionalLocationFeature = feature;
    if (feature.attributes.description !== 'undefined') {
        $("#txtAdditionalLocationDescription").val(feature.attributes.description);
    } else {
        $("#txtAdditionalLocationDescription").val("");
    }
    $('#additionalLocationDialog').modal('show');
}

function saveAdditionalLocation() {
    if (additionalLocationFeature === null || typeof additionalLocationFeature === 'undefined') {
        alert(MSG.ERR.MAP_CONTROL_BAD_FEATURE_STRUCTURE);
        return;
    }
    var description = $("#txtAdditionalLocationDescription").val();
    if (description.length < 1) {
        alert(MSG.ERR.MAP_CONTROL_ADDITIONAL_LOCATION_DESCRIPTION_REQUIRED);
        return;
    }
    additionalLocationFeature.attributes.description = description;
    additionalLocationFeature.layer.redraw();
    $('#additionalLocationDialog').modal('hide');
}

function saveFeatures(requireClaimGeometry) {
    mapControl.toggleMapEditing(false);
    var wkt = new OpenLayers.Format.WKT();
    var additionalLocations = [];

    var parser = new OpenLayers.Format.JSON();
    var claimLayer = mapControl.getMap().getLayer(OT.Map.LAYER_IDS.CURRENT_CLAIM);
    var claimAdditionalLocationsLayer = mapControl.getMap().getLayer(OT.Map.LAYER_IDS.CLAIM_ADDITIONAL_LOCATIONS);

    // Prepare claim geometry
    if (requireClaimGeometry && claimLayer.features.length < 1) {
        alert(MSG.ERR.MAP_CONTROL_CLAIM_GEOMETRY_REQUIERD);
        return false;
    }

    if (claimLayer.features.length > 1) {
        alert(MSG.ERR.MAP_CONTROL_CLAIM_GEOMETRY_MUST_BE_ONE);
        return false;
    }

    var feature;
    
    if (claimLayer.features.length === 1) {
        feature = claimLayer.features[0].clone();
        $("#" + mapControlId.replace(":", "\\:") + "\\:hCurrentClaimArea").val(calculateArea(feature));
        feature.geometry.transform(destCrs, sourceCrs);
        $("#" + mapControlId.replace(":", "\\:") + "\\:hCurrentClaim").val(wkt.write(feature));
    } else {
        $("#" + mapControlId.replace(":", "\\:") + "\\:hCurrentClaimArea").val(0);
        $("#" + mapControlId.replace(":", "\\:") + "\\:hCurrentClaim").val("");
    }
    
    // Prepare claim additional locations
    if (claimAdditionalLocationsLayer.features) {
        for (var i = 0; i < claimAdditionalLocationsLayer.features.length; i++) {
            feature = claimAdditionalLocationsLayer.features[i].clone();

            if (!feature.attributes.description || feature.attributes.description === "") {
                alert(MSG.ERR.MAP_CONTROL_CLAIM_ADDITIONAL_LOCATION_DESCRIPTION_REQUIRED);
                return false;
            }

            feature.geometry.transform(destCrs, sourceCrs);
            additionalLocations.push({
                id: feature.attributes.id ? feature.attributes.id : "tmp" + i,
                description: feature.attributes.description ? feature.attributes.description : "",
                geometry: wkt.write(feature)
            });
        }
    }

    $("#" + mapControlId.replace(":", "\\:") + "\\:hClaimAdditionalLocations").val(parser.write(additionalLocations, false));
    return true;
}
