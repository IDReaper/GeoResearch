function I=MapMatching(line,arc,p,n)
% Syntax
%           -   MapMatching(line,arc,p,n)
%
% INPUT
% line      -   n x 4 matrix representing n edges with [x1 y1 x2 y2] the start and
%               end point
% arc       -   n x 5 matrix representing [xcenter ycenter radius start_angle
%               end_angle]
% p         -   points to map on edges and arcs
% 
% Output
% I         -   row indices for [lines;arc] for any point
%
% See also 
%           -   CSMV, ARCDIST
%
% Author    -   Michael Melzer
%
% History   -   2011 04 18  created

%% determine distance of any point to any edge, orthogonal to edge or
%% euclidean to end points 
[d1]=csmv(line(:,1:2),line(:,3:4),p(:,1:2));

%% determine distance of any point to any arc considering angle of arc and
%% point in relation to center of arc
[d2]=arcdist(arc,p);

%% distance of any point to any edge or arc
d=[d1;d2];
clear d1 d2

%% weighted distance of 3+n points, that the minimum of 3+n points becomes
%% the criteria for edge or arc detection see also Journal of the Eastern
%% Asia Society for Transportation Studies, Vol. 6, pp. 2561 - 2573, 2005
%% THE MAP MATCHING ALGORITHM OF GPS DATA WITH RELATIVELY LONG POLLING TIME
%% INTERVALS (fig. 4)
for i=1:n
    d_weight=d+[d(:,2:end) zeros(size(d,1),1)]+[zeros(size(d,1),1) d(:,1:end-1)];
end;
[mini I]=min(d_weight,[],1);