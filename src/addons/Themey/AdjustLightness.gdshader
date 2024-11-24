shader_type canvas_item;

uniform float brightness_adjust : hint_range(-1.0, 1.0);

// Helper functions
float when_eq(float x, float y) {
    return 1.0 - abs(sign(x - y));
}

// Convert RGB to HSL
vec3 rgb_to_hsl(vec3 rgb) {
    float max_val = max(rgb.r, max(rgb.g, rgb.b));
    float min_val = min(rgb.r, min(rgb.g, rgb.b));
    float delta = max_val - min_val;
    
    float h = 0.0;
    float s = 0.0;
    float l = (max_val + min_val) / 2.0;
    
    if (delta > 0.0) {
        s = delta / (1.0 - abs(2.0 * l - 1.0));
        
        if (max_val == rgb.r) {
            h = (rgb.g - rgb.b) / delta;
        } else if (max_val == rgb.g) {
            h = (rgb.b - rgb.r) / delta + 2.0;
        } else {
            h = (rgb.r - rgb.g) / delta + 4.0;
        }
        
        h /= 6.0;
        if (h < 0.0) h += 1.0; // Ensure h is positive
    }
    
    return vec3(h, s, l);
}

// Convert HSL to RGB
vec3 hsl_to_rgb(vec3 hsl) {
    float h = hsl.x;
    float s = hsl.y;
    float l = hsl.z;
    
    float c = (1.0 - abs(2.0 * l - 1.0)) * s;
    float x = c * (1.0 - abs(mod(h * 6.0, 2.0) - 1.0));
    float m = l - c / 2.0;
    
    vec3 rgb = vec3(0.0);
    
    if (0.0 <= h && h < 1.0 / 6.0) {
        rgb = vec3(c, x, 0.0);
    } else if (1.0 / 6.0 <= h && h < 2.0 / 6.0) {
        rgb = vec3(x, c, 0.0);
    } else if (2.0 / 6.0 <= h && h < 3.0 / 6.0) {
        rgb = vec3(0.0, c, x);
    } else if (3.0 / 6.0 <= h && h < 4.0 / 6.0) {
        rgb = vec3(0.0, x, c);
    } else if (4.0 / 6.0 <= h && h < 5.0 / 6.0) {
        rgb = vec3(x, 0.0, c);
    } else {
        rgb = vec3(c, 0.0, x);
    }
    
    return rgb + vec3(m, m, m);
}


void fragment() {
    vec4 color = texture(TEXTURE, UV);

    // Convert RGB to HSL
    vec3 hsl = rgb_to_hsl(color.rgb);

    // Adjust brightness
    if (brightness_adjust > 0.0) {
        hsl.z = mix(hsl.z, 1.0, brightness_adjust);
    }
	else {
		hsl.z = mix(hsl.z, 0.0, -brightness_adjust);
	}

    // Convert HSL back to RGB
    color.rgb = hsl_to_rgb(hsl);

    COLOR = color;
}
