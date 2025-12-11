(globals 
	version = 3 
	io_order = clockwise 
	space = 20 #Spacing between 2 IO pads 
	total_edge = 3 
) 

(iopad 
	(topleft 
		(inst name="CornerCell1" cell=pfrelr offset=0 orientation=R180 place_status=fixed ) 
	) 
	(left 
		( inst name="m_clk" cell=pc3d01 place_status=fixed) 
		( inst name="m_rst" cell=pc3d01 place_status=fixed) 
		( inst name="VDD" cell=pvdi place_status=fixed) 
	) 
	(topright 
		(inst name="CornerCell2" cell=pfrelr offset=0 orientation=R90 place_status=fixed ) 
	) 
	( top 
		( inst name="p_clk" cell=pc3d01 place_status=fixed) 
		( inst name="p_rst" cell=pc3d01 place_status=fixed) 
		( inst name="p_button" cell=pc3d01 place_status=fixed) 
	) 
	(bottomright 
		(inst name="CornerCell3" cell=pfrelr offset=0 orientation=R0 place_status=fixed ) 
	) 
	( right 
		( inst name="t_light0" cell=pc3o01 place_status=fixed) 
		( inst name="t_light1" cell=pc3o01 place_status=fixed)
		( inst name="p_walk" cell=pc3o01 place_status=fixed) 
	) 
	(bottomleft 
		(inst name="CornerCell4" cell=pfrelr offset=0 orientation=R270 place_status=fixed ) 
	) 
	(bottom 
		( inst name="VDDO" cell=pvda place_status=fixed) 
		( inst name="VSSO" cell=pv0a place_status=fixed) 
		( inst name="VSS" cell=pv0i place_status=fixed) 
	) 
)


