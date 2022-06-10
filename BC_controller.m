function BC_controller(varargin)

    if nargin == 0
        imdata = [0];
    elseif nargin == 1
        imdata = varargin{1};
    else
        error( 'Too many inputs' )
    end

    %figure('Units','centimeters','Position',[0,0,2,5])
    fig = uifigure;
    set(fig,'WindowStyle','alwaysontop')
    fig.Name = 'B & C';
    fig.Position = [ 400,400, 100, 400 ];
   % p = uipanel(fig,'Position',[0,0,1,0.9]);
    
    s(1) = uislider( fig, ...
        'Orientation', 'Vertical', ...
        'Limits',[0,1],'Value', 0);
    s(1).Position([1,2,4]) = [20,20, 300];
    s(1).MajorTickLabels = {};
    s(2) = uislider( fig, ...
        'Orientation', 'Vertical', ...
        'Limits',[0,1],'Value', 1);
    s(2).Position([1,2,4]) = [80,20, 300];
    s(2).MajorTickLabels = {};

   % bt(1) = 


    s(1).ValueChangingFcn = @(sld,event) set_minimum(sld, event, s) ;
    s(2).ValueChangingFcn = @(sld,event) set_maximum(sld, event, s) ;

end

function set_maximum( sld, event, s)
%     axs = findobj('type','Axes');
%     ax = axs(1);
    ax = gca;
    im_h = ax.Children;

    try
        [cmin, cmax] = bounds( im_h.CData(:),'all' );
        crange = cmax - cmin;

        new_clim = crange*[ s(1).Value, event.Value ] + cmin;
        if new_clim(1)<new_clim(2)
            ax.CLim = new_clim;
        end
    catch
        return
    end

end

function set_minimum( sld, event , s)
    %axs = findobj('type','Axes');
    
    %ax = axs(1);
    ax = gca;
    im_h = ax.Children;

    try
        cmin = min( im_h.CData(:) );
        %% 
        cmax = max( im_h.CData(:) );
        crange = cmax - cmin;

        new_clim = crange*[ event.Value, s(2).Value ] + cmin;
        ax.CLim = new_clim;
    catch
        return
    end
end
    



