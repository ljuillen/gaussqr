function h = SurfacePlot_dip(pnts, feval, colorbarunit)
% function h = SurfacePlot_dip(pnts, feval)
%
% This function allows you to plot function values on the surface of a
% sphere.  I guess maybe it works for any manifold, but we only really use
% it for a sphere.
% Delaunay triangulation is used.
%  
% Input arguments
%   pnts - function locations. If you pass only this argument then only the
%          surface will be plotted. This could be useful in order to better 
%          visualize point distributions on a surface.
%   feval - function values
% Output arguments
%   h - plot handle

% Delaunay triangulation of the manifold
d_pnts = delaunayn(pnts);
tr = TriRep(d_pnts, pnts);
faces = freeBoundary(tr);

if nargin == 1
    % Plot the surface only
    h = trisurf(faces,pnts(:,1),pnts(:,2),pnts(:,3),'facecolor',[1,1,0]);
    colormap(gray(256));
    shading interp;
else
    % Plot functions values on the surface
    h = patch('Vertices',pnts,'Faces',faces,'FaceVertexCData',feval,...
        'FaceColor','interp','EdgeColor','none');
    hc = colorbar('EastOutside','FontSize',16);
    if nargin ==3
        xlabel(hc,colorbarunit)
    end
end

axis('equal'); axis('square'); view(-30,20);
xlabel('[m]','FontSize',16);
ylabel('[m]','FontSize',16);
zlabel('[m]','FontSize',16);
grid on;

if nargout==0 % Don't return anything if not requested
    clear h;
end

end

