<mxfile host="app.diagrams.net" agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36" version="26.2.14">
  <diagram id="R2lEEEUBdFMjLlhIrx00" name="Page-1">
    <mxGraphModel dx="2160" dy="828" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="850" pageHeight="1100" math="0" shadow="0" extFonts="Permanent Marker^https://fonts.googleapis.com/css?family=Permanent+Marker">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="Xni7guDJES_wgA18quzG-27" value="USER" style="swimlane;childLayout=stackLayout;horizontal=1;startSize=50;horizontalStack=0;rounded=1;fontSize=14;fontStyle=0;strokeWidth=2;resizeParent=0;resizeLast=1;shadow=0;dashed=0;align=center;arcSize=4;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="340" y="40" width="160" height="140" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-28" value="id(PK)&lt;div&gt;name&lt;/div&gt;&lt;div&gt;email&lt;/div&gt;&lt;div&gt;role&lt;/div&gt;&lt;div&gt;password_hash&lt;/div&gt;" style="align=left;strokeColor=none;fillColor=none;spacingLeft=4;spacingRight=4;fontSize=12;verticalAlign=top;resizable=0;rotatable=0;part=1;html=1;whiteSpace=wrap;" vertex="1" parent="Xni7guDJES_wgA18quzG-27">
          <mxGeometry y="50" width="160" height="90" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-29" value="EVENT" style="swimlane;childLayout=stackLayout;horizontal=1;startSize=50;horizontalStack=0;rounded=1;fontSize=14;fontStyle=0;strokeWidth=2;resizeParent=0;resizeLast=1;shadow=0;dashed=0;align=center;arcSize=4;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="345" y="260" width="160" height="170" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-30" value="id(PK)&lt;div&gt;name&lt;/div&gt;&lt;div&gt;start_date&lt;/div&gt;&lt;div&gt;end_date&lt;/div&gt;&lt;div&gt;location&lt;/div&gt;&lt;div&gt;description&lt;/div&gt;&lt;div&gt;organiser_id(FK)&lt;/div&gt;" style="align=left;strokeColor=none;fillColor=none;spacingLeft=4;spacingRight=4;fontSize=12;verticalAlign=top;resizable=0;rotatable=0;part=1;html=1;whiteSpace=wrap;" vertex="1" parent="Xni7guDJES_wgA18quzG-29">
          <mxGeometry y="50" width="160" height="120" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-31" value="TICKET" style="swimlane;childLayout=stackLayout;horizontal=1;startSize=50;horizontalStack=0;rounded=1;fontSize=14;fontStyle=0;strokeWidth=2;resizeParent=0;resizeLast=1;shadow=0;dashed=0;align=center;arcSize=4;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry y="510" width="160" height="170" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-32" value="id(PK)&lt;div&gt;event_id(FK)&lt;/div&gt;&lt;div&gt;attendee_id(FK)&lt;/div&gt;&lt;div&gt;qr_code&lt;/div&gt;&lt;div&gt;price&lt;/div&gt;&lt;div&gt;seat_info&lt;/div&gt;&lt;div&gt;purchase_date&lt;/div&gt;" style="align=left;strokeColor=none;fillColor=none;spacingLeft=4;spacingRight=4;fontSize=12;verticalAlign=top;resizable=0;rotatable=0;part=1;html=1;whiteSpace=wrap;" vertex="1" parent="Xni7guDJES_wgA18quzG-31">
          <mxGeometry y="50" width="160" height="120" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-33" value="TASK" style="swimlane;childLayout=stackLayout;horizontal=1;startSize=50;horizontalStack=0;rounded=1;fontSize=14;fontStyle=0;strokeWidth=2;resizeParent=0;resizeLast=1;shadow=0;dashed=0;align=center;arcSize=4;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="220" y="510" width="160" height="160" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-34" value="id(PK)&lt;div&gt;event_id(FK)&lt;/div&gt;&lt;div&gt;assigned_to(FK)&lt;/div&gt;&lt;div&gt;description&lt;/div&gt;&lt;div&gt;deadline&lt;/div&gt;&lt;div&gt;status&lt;/div&gt;" style="align=left;strokeColor=none;fillColor=none;spacingLeft=4;spacingRight=4;fontSize=12;verticalAlign=top;resizable=0;rotatable=0;part=1;html=1;whiteSpace=wrap;" vertex="1" parent="Xni7guDJES_wgA18quzG-33">
          <mxGeometry y="50" width="160" height="110" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-35" value="FEEDBACK" style="swimlane;childLayout=stackLayout;horizontal=1;startSize=50;horizontalStack=0;rounded=1;fontSize=14;fontStyle=0;strokeWidth=2;resizeParent=0;resizeLast=1;shadow=0;dashed=0;align=center;arcSize=4;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="505" y="510" width="160" height="156" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-36" value="id(PK)&lt;div&gt;event_id(FK)&lt;/div&gt;&lt;div&gt;attendee_id(FK)&lt;/div&gt;&lt;div&gt;rating&lt;/div&gt;&lt;div&gt;comments&lt;/div&gt;&lt;div&gt;submission_date&lt;/div&gt;" style="align=left;strokeColor=none;fillColor=none;spacingLeft=4;spacingRight=4;fontSize=12;verticalAlign=top;resizable=0;rotatable=0;part=1;html=1;whiteSpace=wrap;" vertex="1" parent="Xni7guDJES_wgA18quzG-35">
          <mxGeometry y="50" width="160" height="106" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-37" value="NOTIFICATION" style="swimlane;childLayout=stackLayout;horizontal=1;startSize=50;horizontalStack=0;rounded=1;fontSize=14;fontStyle=0;strokeWidth=2;resizeParent=0;resizeLast=1;shadow=0;dashed=0;align=center;arcSize=4;whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="730" y="510" width="160" height="150" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-38" value="id(PK)&lt;div&gt;recipient_id(FK)&lt;/div&gt;&lt;div&gt;event_id(FK)&lt;/div&gt;&lt;div&gt;message&lt;/div&gt;&lt;div&gt;send_time&lt;/div&gt;&lt;div&gt;is_read&lt;/div&gt;" style="align=left;strokeColor=none;fillColor=none;spacingLeft=4;spacingRight=4;fontSize=12;verticalAlign=top;resizable=0;rotatable=0;part=1;html=1;whiteSpace=wrap;" vertex="1" parent="Xni7guDJES_wgA18quzG-37">
          <mxGeometry y="50" width="160" height="100" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-41" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;exitX=0.5;exitY=0;exitDx=0;exitDy=0;entryX=0.429;entryY=-0.026;entryDx=0;entryDy=0;entryPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-37" target="Xni7guDJES_wgA18quzG-37">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-50" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=0.629;exitY=1.015;exitDx=0;exitDy=0;entryX=0.594;entryY=0;entryDx=0;entryDy=0;entryPerimeter=0;exitPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-28" target="Xni7guDJES_wgA18quzG-29">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="600" y="80" as="sourcePoint" />
            <mxPoint x="600" y="160" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-51" value="organizes" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-50">
          <mxGeometry x="-0.0774" y="-2" relative="1" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-52" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;exitX=0.013;exitY=0.334;exitDx=0;exitDy=0;exitPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-53" target="Xni7guDJES_wgA18quzG-31">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="330" y="80" as="sourcePoint" />
            <mxPoint x="90" y="80" as="targetPoint" />
            <Array as="points">
              <mxPoint x="80" y="350" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-54" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;exitX=0.013;exitY=0.334;exitDx=0;exitDy=0;exitPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-27" target="Xni7guDJES_wgA18quzG-53">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="342" y="87" as="sourcePoint" />
            <mxPoint x="80" y="510" as="targetPoint" />
            <Array as="points" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-53" value="Purchases" style="text;html=1;align=center;verticalAlign=middle;resizable=0;points=[];autosize=1;strokeColor=none;fillColor=none;" vertex="1" parent="1">
          <mxGeometry x="120" y="260" width="80" height="30" as="geometry" />
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-55" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=1;exitY=0.25;exitDx=0;exitDy=0;entryX=0.671;entryY=0.016;entryDx=0;entryDy=0;entryPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-28" target="Xni7guDJES_wgA18quzG-37">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="550" y="450" as="sourcePoint" />
            <mxPoint x="650" y="350" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-56" value="Receives" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=16;" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-55">
          <mxGeometry x="-0.0337" relative="1" as="geometry">
            <mxPoint x="2" y="4" as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-57" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=0;exitY=0;exitDx=0;exitDy=0;entryX=0.75;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-30" target="Xni7guDJES_wgA18quzG-31">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="180" y="410" as="sourcePoint" />
            <mxPoint x="280" y="310" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-58" value="&lt;font style=&quot;font-size: 16px;&quot;&gt;has&lt;/font&gt;" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-57">
          <mxGeometry x="-0.0379" y="4" relative="1" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-59" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=0.392;exitY=1.04;exitDx=0;exitDy=0;exitPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-30" target="Xni7guDJES_wgA18quzG-33">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="540" y="430" as="sourcePoint" />
            <mxPoint x="640" y="330" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-60" value="assigns" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=16;" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-59">
          <mxGeometry x="0.1014" y="-3" relative="1" as="geometry">
            <mxPoint x="-1" as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-63" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=0.75;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-30" target="Xni7guDJES_wgA18quzG-35">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="540" y="430" as="sourcePoint" />
            <mxPoint x="640" y="330" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-64" value="&lt;font style=&quot;font-size: 16px;&quot;&gt;receives feedback&lt;/font&gt;" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-63">
          <mxGeometry x="-0.2368" y="-2" relative="1" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-65" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=1.031;exitY=0.892;exitDx=0;exitDy=0;exitPerimeter=0;entryX=0.333;entryY=-0.02;entryDx=0;entryDy=0;entryPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-30" target="Xni7guDJES_wgA18quzG-37">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="540" y="430" as="sourcePoint" />
            <mxPoint x="640" y="330" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-66" value="&lt;font style=&quot;font-size: 16px;&quot;&gt;generates&lt;/font&gt;" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-65">
          <mxGeometry x="0.0456" y="5" relative="1" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-67" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=0;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="350" y="180" as="sourcePoint" />
            <mxPoint x="310" y="510" as="targetPoint" />
            <Array as="points">
              <mxPoint x="300" y="310" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-68" value="&lt;font style=&quot;font-size: 16px;&quot;&gt;assigned to&lt;/font&gt;" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-67">
          <mxGeometry x="-0.3762" y="-3" relative="1" as="geometry">
            <mxPoint x="-9" y="-3" as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-70" value="" style="fontSize=12;html=1;endArrow=ERoneToMany;rounded=0;exitX=1;exitY=1;exitDx=0;exitDy=0;entryX=0.663;entryY=0.016;entryDx=0;entryDy=0;entryPerimeter=0;" edge="1" parent="1" source="Xni7guDJES_wgA18quzG-28" target="Xni7guDJES_wgA18quzG-35">
          <mxGeometry width="100" height="100" relative="1" as="geometry">
            <mxPoint x="540" y="420" as="sourcePoint" />
            <mxPoint x="640" y="320" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="Xni7guDJES_wgA18quzG-71" value="&lt;font style=&quot;font-size: 16px;&quot;&gt;submitted by&lt;/font&gt;" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];" vertex="1" connectable="0" parent="Xni7guDJES_wgA18quzG-70">
          <mxGeometry x="-0.0581" y="-3" relative="1" as="geometry">
            <mxPoint x="11" y="8" as="offset" />
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
