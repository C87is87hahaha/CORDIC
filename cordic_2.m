clear all,clc;

k = 1.64676; m = 1; n = 8;
x = 1; y = 0.43;
z = 0;

for i  = 1 :  1 : n
 	if y >= 0
		simga = -sign(x*y);
%       simga = -1;
		alp = atan(2.^(-1*i));
		simga_i = simga * 2.^(-1*i);
		simga_i_f = floor(simga_i*(2.^2))/2.^2;

		%%%   calculate x value   %%%

		y_simga_i = y * simga_i_f;
		y_simga_i_f = floor(y_simga_i*(2.^2))/2.^2;
		m_y_simga_i = m * y_simga_i_f;
		m_y_simga_i_f = floor(m_y_simga_i*(2.^2))/2.^2;
		x_new = x - m_y_simga_i_f;
		x_new_f = floor(x_new*(2.^2))/2.^2;

		%%%   calculate y value   %%%

		x_simga_i = x * simga_i_f;
		x_simga_i_f = floor(x_simga_i*(2.^2))/2.^2;
		y_new = y + x_simga_i_f;
		y_new_f = floor(y_new*(2.^2))/2.^2;

		%%%   calculate z value   %%%

		simga_alp = simga * alp;
		simga_alp_f = floor(simga_alp*(2.^2))/2.^2;
		z_new = z - simga_alp_f;
		z_new_f = floor(z_new*(2.^2))/2.^2;

		x = x_new_f;
		y = y_new_f;
		z = z_new_f;

	else

		simga = sign(x*y);
		simga = 1;
        alp = atan(2.^(-1*i));
		simga_i = simga * 2.^(-1*i);
		simga_i_f = floor(simga_i*(2.^2))/2.^2;

		%%%   calculate x value   %%%

		y_simga_i = y * simga_i_f;
		y_simga_i_f = floor(y_simga_i*(2.^2))/2.^2;
		m_y_simga_i = m * y_simga_i_f;
		m_y_simga_i_f = floor(m_y_simga_i*(2.^2))/2.^2;
		x_new = x - m_y_simga_i_f;
		x_new_f = floor(x_new*(2.^2))/2.^2;

		%%%   calculate y value   %%%

		x_simga_i = x * simga_i_f;
		x_simga_i_f = floor(x_simga_i*(2.^2))/2.^2;
		y_new = y + x_simga_i_f;
		y_new_f = floor(y_new*(2.^2))/2.^2;

		%%%   calculate z value   %%%

		simga_alp = simga * alp;
		simga_alp_f = floor(simga_alp*(2.^2))/2.^2;
		z_new = z - simga_alp_f;
		z_new_f = floor(z_new*(2.^2))/2.^2;
		x = x_new_f;
		y = y_new_f;
		z = z_new_f;

    end
end
 
% x_k = x * k; x_k_f = floor(x_k*(2.^2))/2.^2;
% y_k = y * k; y_k_f = floor(y_k*(2.^2))/2.^2;
% z_k = z;
