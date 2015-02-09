function part_dist_of_exemplars = get_part_dist_of_exemplars(feasible_global_models)
    
    %
    
    
    %
    inter_ocular_dist = 55;
    number_of_exemplars = size(feasible_global_models, 1);
    number_of_parts     = size(feasible_global_models{1},1);
    inter_exemplars_dist = Inf * ones(number_of_exemplars, number_of_exemplars);
    part_dist_of_exemplars = cell(number_of_exemplars, 1);
    
    %
    for i=1:number_of_exemplars
        for j=(i+1):number_of_exemplars
       
            part_I = feasible_global_models{i};
            part_J = feasible_global_models{j};
            
            X_I = [ part_I(:,1) ; part_I(:,1) ];
            X_J = [ part_J(:,1) ; part_J(:,2) ];
            
            inter_exemplars_dist(i,j) = pdist([X_I'; X_J']);
            inter_exemplars_dist(j,i) = inter_exemplars_dist(i,j);
            
        end
    end

    %
    for i=1:number_of_exemplars
        [value nearest_exemplar] = min(inter_exemplars_dist(:,i));
        gaussian_parameters = zeros(number_of_parts, 4);
        part_I = feasible_global_models{i};
        part_J = feasible_global_models{nearest_exemplar};
        for j=1:number_of_parts
            x0 = part_I(j,1);
            y0 = part_I(j,2);
            sigma_x = abs(x0 - part_J(j,1)) / inter_ocular_dist;
            sigma_y = abs(y0 - part_J(j,2)) / inter_ocular_dist;
            gaussian_parameters(j, :) = [x0 y0 sigma_x sigma_y];
        end
        part_dist_of_exemplars{i} = gaussian_parameters;
    end
    
    
end