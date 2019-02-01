<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0"
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
 xmlns="http://www.opengis.net/sld"
 xmlns:ogc="http://www.opengis.net/ogc"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <!-- a Named Layer is the basic building block of an SLD document -->
  <NamedLayer>
    <Name>claim_polygon</Name>
    <UserStyle>
    <!-- Styles can have names, titles and abstracts -->
      <Title>Claim Polygon</Title>
      <Abstract>Claim style that draws a polygon</Abstract>
      <FeatureTypeStyle>
        <Rule>
          <Name>rule1</Name>
          <Title>Unmoderated claims</Title>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#FFFFFF</CssParameter>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#FFE900</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
          <TextSymbolizer>
            <Geometry>
              <ogc:Function name="centroid">
                <ogc:PropertyName>mapped_geometry</ogc:PropertyName>
              </ogc:Function>
            </Geometry>
           <Label>
             #<ogc:PropertyName>nr</ogc:PropertyName>
           </Label>
           <LabelPlacement>
             <PointPlacement>
               <AnchorPoint>
                 <AnchorPointX>0.5</AnchorPointX>
                 <AnchorPointY>0.5</AnchorPointY>
               </AnchorPoint>
             </PointPlacement>
           </LabelPlacement>
           <Halo>
             <Radius>2</Radius>
             <Fill>
               <CssParameter name="fill">#FFFFFF</CssParameter>
             </Fill>
           </Halo>
           <VendorOption name="conflictResolution">true</VendorOption>
           <VendorOption name="goodnessOfFit">0</VendorOption>
           <VendorOption name="autoWrap">60</VendorOption>
         </TextSymbolizer>
        </Rule>
    <Rule>
    <Name>rule2</Name>
    <Title>Claims for review</Title>
      <ogc:Filter>
    <ogc:And>
      <ogc:PropertyIsEqualTo>
        <ogc:PropertyName>status_code</ogc:PropertyName>
        <ogc:Literal>unmoderated</ogc:Literal>
      </ogc:PropertyIsEqualTo>
      <ogc:PropertyIsEqualTo>
        <ogc:PropertyName>expired</ogc:PropertyName>
        <ogc:Literal>true</ogc:Literal>
      </ogc:PropertyIsEqualTo>
    </ogc:And>
      </ogc:Filter>
    <PolygonSymbolizer>
    <Fill>
      <CssParameter name="fill">#FFFFFF</CssParameter>
      <CssParameter name="fill-opacity">0</CssParameter>
    </Fill>
    <Stroke>
            <CssParameter name="stroke">#FF9500</CssParameter>
    </Stroke>
    </PolygonSymbolizer>
  </Rule>
        <Rule>
          <Name>rule4</Name>
          <Title>Reviewed claims</Title>
      <ogc:Filter>
      <ogc:PropertyIsEqualTo>
        <ogc:PropertyName>status_code</ogc:PropertyName>
        <ogc:Literal>reviewed</ogc:Literal>
      </ogc:PropertyIsEqualTo>
      </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#FFFFFF</CssParameter>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
      <Stroke>
        <CssParameter name="stroke">#73FF00</CssParameter>
      </Stroke>
          </PolygonSymbolizer>
        </Rule>
    <Rule>
    <Name>rule3</Name>
    <Title>Moderated claims</Title>
      <ogc:Filter>
      <ogc:PropertyIsEqualTo>
        <ogc:PropertyName>status_code</ogc:PropertyName>
        <ogc:Literal>moderated</ogc:Literal>
      </ogc:PropertyIsEqualTo>
      </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#FFFFFF</CssParameter>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
      <Stroke>
        <CssParameter name="stroke">#4EAD00</CssParameter>
      </Stroke>
          </PolygonSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>