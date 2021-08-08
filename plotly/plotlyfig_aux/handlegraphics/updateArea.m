function updateArea(obj,areaIndex)

% x: ...[DONE]
% y: ...[DONE]
% r: ...[NOT SUPPORTED IN MATLAB]
% t: ...[NOT SUPPORTED IN MATLAB]
% mode: ...[DONE]
% name: ...[DONE]
% text: ...[NOT SUPPORTED IN MATLAB]
% error_y: ...[HANDLED BY ERRORBAR]
% error_x: ...[HANDLED BY ERRORBAR]

%----marker----%

% color: ...[NA]
% size: ...[NA]
% symbol: ...[NA]
% opacity: ...[NA]
% sizeref: ...[NA]
% sizemode: ...[NA]
% colorscale: ...[NA]
% cauto: ...[NA]
% cmin: ...[NA]
% cmax: ...[NA]
% outliercolor: ...[NA]
% maxdisplayed: ...[NA]

%----marker line----%

% color: ...[NA]
% width: ...[NA]
% dash: ...[NA]
% opacity: ...[NA]
% shape: ...[NA]
% smoothing: ...[NA]
% outliercolor: ...[NA]
% outlierwidth: ...[NA]

%----line----%
% color: .........[TODO]
% width: .........[TODO]
% dash: .........[TODO]
% opacity: .........[TODO]
% shape: ...[NA]
% smoothing: ...[NA]
% outliercolor: ...[NA]
% outlierwidth: ...[NA]

% textposition: ...[NOT SUPPORTED IN MATLAB]
% textfont: ...[NOT SUPPORTED IN MATLAB]
% connectgaps: ...[NOT SUPPORTED IN MATLAB]
% fill: ...[DONE]
% fillcolor: ..........[TODO]
% opacity: ..........[TODO]
% xaxis: ...[DONE]
% yaxis: ....[DONE]
% showlegend: ...[DONE]
% stream: ...[HANDLED BY PLOTLYSTREAM]
% visible: ...[DONE]
% type: ...[DONE]

%-------------------------------------------------------------------------%

%-store original area handle-%
area_data = obj.State.Plot(areaIndex).Handle; 

%------------------------------------------------------------------------%

%-get "children" using new HG2 approach-%
area_child = get(area_data.java.firstDown); 

%------------------------------------------------------------------------%

%-AXIS INDEX-%
axIndex = obj.getAxisIndex(obj.State.Plot(areaIndex).AssociatedAxis);

%-CHECK FOR MULTIPLE AXES-%
[xsource, ysource] = findSourceAxis(obj,axIndex);

%-AXIS DATA-%
eval(['xaxis = obj.layout.xaxis' num2str(xsource) ';']);
eval(['yaxis = obj.layout.yaxis' num2str(ysource) ';']);

%-------------------------------------------------------------------------%

%-area xaxis-%
obj.data{areaIndex}.xaxis = ['x' num2str(xsource)];

%-------------------------------------------------------------------------%

%-area yaxis-%
obj.data{areaIndex}.yaxis = ['y' num2str(ysource)];

%-------------------------------------------------------------------------%

%-area type-%
obj.data{areaIndex}.type = 'scatter';

%-------------------------------------------------------------------------%

%-area x-%
obj.data{areaIndex}.x = area_data.XData;

%-------------------------------------------------------------------------%

%-area y-%
if areaIndex>1
    obj.data{areaIndex}.y = obj.data{areaIndex-1}.y + area_data.YData;
else
    obj.data{areaIndex}.y = area_data.YData;
end

%-------------------------------------------------------------------------%

%-area name-%
try
    obj.data{areaIndex}.name = area_data.DisplayName;
catch
    obj.data{areaIndex}.name = '';
end

%-------------------------------------------------------------------------%

%-area visible-%
obj.data{areaIndex}.visible = strcmp(area_data.Visible,'on');

%-------------------------------------------------------------------------%

%-area fill-%
obj.data{areaIndex}.fill = 'tonexty';

%-------------------------------------------------------------------------%

%-AREA MODE-%
obj.data{areaIndex}.mode = 'lines';

%-------------------------------------------------------------------------%

%-area line-%
obj.data{areaIndex}.line = extractAreaLine(area_data);

%-------------------------------------------------------------------------%

%-area fillcolor-%
fill = extractAreaFace(area_data);
obj.data{areaIndex}.fillcolor = fill.color;

%-------------------------------------------------------------------------%

%-area showlegend-%
leg = get(area_data.Annotation);
legInfo = get(leg.LegendInformation);

switch legInfo.IconDisplayStyle
    case 'on'
        showleg = true;
    case 'off'
        showleg = false;
end

obj.data{areaIndex}.showlegend = showleg;

%-------------------------------------------------------------------------%

end


