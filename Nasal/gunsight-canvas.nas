#todo: make sure we have enough voltage. update me.power() for that.

var fixednetswitch = "/controls/armament/gunsight/fixed-net-power-switch";
var pipperpowerswitch = "/controls/armament/gunsight/pipper-power-switch";
var pipperscale = "/controls/armament/gunsight/pipper-scale";
var redpath = "/controls/armament/gunsight/red";
var bluepath = "/controls/armament/gunsight/blue";
var greenpath = "/controls/armament/gunsight/green";
var fixed_net_alphapath = "/controls/armament/gunsight/fixed-net-brightness-knob";
var fontsizepath = "/controls/armament/gunsight/font-size";
var linewidthpath = "/controls/armament/gunsight/thickness";
var viewX = "/sim/current-view/x-offset-m";
var viewY = "/sim/current-view/y-offset-m";
var viewZ = "/sim/current-view/z-offset-m";
var ghosting_x = "/controls/armament/gunsight/ghosting-x";
var ghosting_y = "/controls/armament/gunsight/ghosting-y";
var scaling = "/controls/armament/gunsight/scaling";
var sight_align_elevation = "/controls/armament/gunsight/elevation";
var sight_align_windage = "/controls/armament/gunsight/windage";

var startViewX = getprop(viewX);
var startViewY = getprop(viewY);
var startViewZ = getprop(viewZ);

var clamp = func(v, min, max) { v < min ? min : v > max ? max : v }

var FALSE = 0;
var TRUE  = 1;


var gun_sight = {
	
	
	canvas_settings: {
	  "name": "gunsight",   # The name is optional but allow for easier identification
	  "size": [1024, 1024], # Size of the underlying texture (should be a power of 2, required) [Resolution]
	  "view": [1024, 1024],  # Virtual resolution (Defines the coordinate system of the canvas [Dimensions]
							# which will be stretched the size of the texture, required)
	  "mipmapping": 1       # Enable mipmapping (optional)
	},
	new: func(placement)
	{
		var m = {
			parents: [gun_sight],
			gunsight: canvas.new(gun_sight.canvas_settings)
		};
	
		#gunsight settings
				
		#gunsight canvas
		
		var dR = m.getColor(redpath);
		var dG = m.getColor(greenpath);
		var dB = m.getColor(bluepath);
		var dA = getprop(fixed_net_alphapath);
		var fS = getprop(fontsizepath);	#font size
		var lW = getprop(linewidthpath);		#line width
	
		m.gunsight.addPlacement(placement);
		m.gunsight.setColorBackground(0,0,0,0);

		
		
		############################################################
		## GUNSIGHT CANVAS + LISTENERS ####################################
		############################################################
		
		m.gsight = m.gunsight.createGroup();
		m.gschild = [];
		m.fixed_net_centers = [];
		
		append(m.gschild, m.gsight.createChild("path", "straights")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW)
			.setStrokeLineCap("round")
			.moveTo(512,326)
			.lineTo(512,533)
			.moveTo(512,555)
			.lineTo(512,575)
			.moveTo(512,595)
			.lineTo(512,617)
			.moveTo(512,637)
			.lineTo(512,946)
			.moveTo(345,500)
			.lineTo(345,527)
			.moveTo(428,500)
			.lineTo(428,527)
			.moveTo(593,500)
			.lineTo(593,527)
			.moveTo(676,500)
			.lineTo(676,527)
			.moveTo(501,346)
			.lineTo(523,346)
			.moveTo(501,432)
			.lineTo(523,432)
			.moveTo(501,720)
			.lineTo(523,720)
			.moveTo(501,823)
			.lineTo(523,823)
			.moveTo(501,886)
			.lineTo(523,886)
			.moveTo(489,555)
			.lineTo(501,555)
			.moveTo(523,555)
			.lineTo(535,555)
			.moveTo(489,596)
			.lineTo(501,596)
			.moveTo(523,596)
			.lineTo(535,596)
			.moveTo(489,637)
			.lineTo(501,637)
			.moveTo(523,637)
			.lineTo(535,637)
			.moveTo(489,680)
			.lineTo(535,680)
			.moveTo(489,761)
			.lineTo(535,761)
			.moveTo(489,844)
			.lineTo(535,844)
			.moveTo(489,924)
			.lineTo(535,924)
			.moveTo(428,514)
			.lineTo(448,514)
			.moveTo(468,514)
			.lineTo(488,514)
			.moveTo(533,514)
			.lineTo(553,514)
			.moveTo(573,514)
			.lineTo(593,514)
			.moveTo(198,826)
			.lineTo(424,600)
			.moveTo(341,922)
			.lineTo(367,858)
			.moveTo(399,782)
			.lineTo(431,704)
			.moveTo(674,922)
			.lineTo(648,858)
			.moveTo(618,782)
			.lineTo(587,704)
			.moveTo(819,826)
			.lineTo(593,600)
			.moveTo(278,751)
			.lineTo(273,746)
			.moveTo(367,662)
			.lineTo(362,657)
			.moveTo(396,633)
			.lineTo(391,628)
			.moveTo(621,633)
			.lineTo(626,628)
			.moveTo(650,662)
			.lineTo(655,657)
			.moveTo(739,751)
			.lineTo(744,746)
			.moveTo(499,573)
			.lineTo(525,547)
			.moveTo(499,547)
			.lineTo(525,573)
			.moveTo(505,622)
			.lineTo(519,608)
			.moveTo(505,608)
			.lineTo(519,622));
			
		append(m.gschild, m.gsight.createChild("path", "inarc")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW)
			.setStrokeLineCap("round")
			.moveTo(259,479)
			.arcLargeCCWTo(255,255,0,765,479)
			.setStrokeDashArray([69,38,38,38,38,38,38,38,38,116,38,38,38,38,38,38,38,38,69])); # curve is 868 pixels 362
			
		append(m.gschild, m.gsight.createChild("path", "outarc")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW)
			.setStrokeLineCap("round")
			.moveTo(195,782)
			.arcSmallCCWTo(416,416,0,821,782)
			.setStrokeDashArray([40,40,40,40,40,40,40,147,40,40,40,40,40,40,40]));
		
		for (var i = 0; i < size(m.gschild); i += 1 ) {
			append(m.fixed_net_centers, m.gschild[i].getCenter());
		}
		
		setlistener(fixednetswitch,func { m.fixed_net_power() });
				
		m.fixed_net_power();
		setlistener(viewX,func { m.fixednet_updateXY() });
		setlistener(viewY,func { m.fixednet_updateXY() });
		
		############################################################
		## PIPPER CANVAS + LISTENERS ######################################
		############################################################
		
		m.pipper = m.gunsight.createGroup();
		
		m.pipper_elems = [];
		
		append(m.pipper_elems, m.pipper.createChild("path", "center")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 2)
			.setStrokeLineCap("round")
			.moveTo(-7,0)
			.arcSmallCW(7,7,0,14,0)
			.arcSmallCW(7,7,0,-14,0)
			.setTranslation(512,512));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 270")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(412,512)
			.setRotation(0,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 315")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(441,441)
			.setRotation(45 * D2R,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 360")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(512,412)
			.setRotation(90 * D2R,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 45")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(583,441)
			.setRotation(135 * D2R,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 90")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(612,512)
			.setRotation(180 * D2R,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 135")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(583,583)
			.setRotation(225 * D2R,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 180")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(512,612)
			.setRotation(270 * D2R,0));
			
		append(m.pipper_elems, m.pipper.createChild("path","diamond 225")
			.setColor(dR,dG,dB,dA)
			.setStrokeLineWidth(lW * 0.95)
			.setStrokeLineCap("round")
			.line(-24,9)
			.line(-6,-9)
			.line(6,-9)
			.line(24,9)
			.setTranslation(441,583)
			.setRotation(315 * D2R,0));
			
		m.pipper_center = [512,512];
			
		setlistener(pipperpowerswitch, func { m.pipper_power(); } );
		setlistener(pipperscale, func { m.pipper_move(); } );
		
		m.pipper_power();
		
		############################################################
		## JOINT LISTENERS ##############################################
		############################################################
		
		setlistener(redpath,func { m.updateColor() });
		setlistener(bluepath,func { m.updateColor() });
		setlistener(greenpath,func { m.updateColor() });
		setlistener(fixed_net_alphapath,func { m.updateColor() });
		
		setlistener(linewidthpath,func { m.updateWidth() });
		
		m.update();
	},
	update: func() {
		me.pipper_move();
		settimer(func { me.update(); }, 0);
	},
	fixed_net_power: func() {
		var switch_state = getprop(fixednetswitch);
		if ( switch_state == 1 ) {
			for (var i = 0; i < size(me.gschild); i += 1 ) {
				me.gschild[i].show();
			}
		} else {
			for (var i = 0; i < size(me.gschild); i += 1 ) {
				me.gschild[i].hide();
			}	
		}
	},
	fixednet_updateXY: func() {
		
		var curViewX = getprop(viewX);
		var curViewY = getprop(viewY);
		
		var ghostx = getprop(ghosting_x);
		var ghosty = getprop(ghosting_y);
		
		var s_ele = getprop(sight_align_elevation);
		var s_win = getprop(sight_align_windage);
		
		var changeViewX = (startViewX-getprop(viewX))*ghostx;
		var changeViewY = (startViewY-getprop(viewY))*ghosty;
	
		for (var i = 0; i < size(me.gschild); i += 1 ) {
			me.gschild[i].setTranslation(-1 * changeViewX + s_win, changeViewY + s_ele);
		}
    },
	
	pipper_power: func() {
		var switch_state = getprop(pipperpowerswitch);
		if ( switch_state == 1 ) {
			foreach ( var elem; me.pipper.getChildren() ) {
				elem.show();
			}
		} else {
		foreach ( var elem; me.pipper.getChildren() ) {
				elem.hide();
			}
		}
	},
	
	pipper_move: func() {
		var scale = getprop(pipperscale);
		for ( var i = 0; i < size(me.pipper_elems); i += 1 ) {
			#only translate the outside elements.
			if ( i != 0 ) {
				var angle = (180 - (45 * (i - 1))) * D2R;
				me.pipper_elems[i].setTranslation(me.pipper_center[0] + scale * math.cos(angle), me.pipper_center[1] + -1 * scale * math.sin(angle));
			}
		}
	},
	
	
	updateColor: func() {
		var dR = me.getColor(redpath);
		var dB = me.getColor(bluepath);
		var dG = me.getColor(greenpath);
		var dA = getprop(fixed_net_alphapath);
		for (var i = 0; i < size(me.gschild); i += 1 ) {
			me.gschild[i].setColor(dR,dG,dB,dA);
		}
	},
	updateWidth: func() {
		var lW = getprop(linewidthpath);
		for (var i = 0; i < size(me.gschild); i += 1 ) {
			me.gschild[i].setStrokeLineWidth(lW);
		}
	},
	getColor: func(path) {
		x = getprop(path);
		y = x == 0 ? 0 : x > 0 ? x / 255 : x; # if x == 0 return 0 else return x / 255
		return y;
	}
};

var init = setlistener("/sim/signals/fdm-initialized", func() {
  #print("inniting");
  removelistener(init); # only call once
  var gs = gun_sight.new({"node": "sight"});
#  var hud_copilot = HUD.new({"node": "HUD.l.canvas.001"});
#  hud_copilot.update();
});
