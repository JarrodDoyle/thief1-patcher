// sw_cc shaders which crudely emulate 16-bit dithered rendering, for a retro-HW look (using a 4x4 bayer matrix)
//
// to use this, copy the file to the "shaders" directory and rename it to cc.fx

static const float3 LUMINANCE_VECTOR = float3(0.2125, 0.7154, 0.0721);

float g_fGamma;
float g_fSaturation;
float g_fContrast;
float g_fBrightness;
float4 g_fColorFilter;
float2 g_fScreenSize;

// the frame texture
sampler s0 : register(s0);


#define bK 16.0
static const float bayerMatrix[4*4] = { 0,  8/bK,  2/bK,  10/bK,   12/bK, 4/bK,  14/bK, 6/bK,   3/bK,  11/bK, 1/bK,  9/bK,   15/bK, 7/bK,  13/bK, 5/bK };

float bayerValue(float2 vPos)
{
	int2 ij = int2( fmod(vPos, 4.0) );
	return bayerMatrix[ij.x + ij.y * 4];
}

float3 Dither16(float3 vColor, float2 uv)
{
	uv *= g_fScreenSize;

	float3 c16 = vColor * float3(32,64,32);
	float3 fr = frac(c16);

	float3 c1 = c16 - fr;
	float3 c2 = (c1 + 1.0) * (1.0 / float3(32,64,32));
	c1 *= 1.0 / float3(32,64,32);

	return (fr < bayerValue(uv)) ? c1 : c2;
}


float4 SatGammaPS(in float2 uv : TEXCOORD0, uniform int bDoSat, uniform int bDoGamma, uniform int bDoContrBright) : COLOR
{
	float4 vColor = tex2D(s0, uv);

	if (bDoSat)
	{
		float lumi = dot(vColor.xyz, LUMINANCE_VECTOR);
		vColor.xyz = lerp(lumi.xxx, vColor.xyz, g_fSaturation) * g_fColorFilter.xyz;
	}
	if (bDoGamma)
	{
		vColor.xyz = pow(vColor.xyz, g_fGamma);
	}
	if (bDoContrBright)
	{
		// old not quite correct contrast formula used in T2 v1.25 / SS2 v2.46 and older
		//vColor.xyz = saturate(vColor.xyz * g_fContrast + g_fBrightness);

		vColor.xyz = saturate((vColor.xyz - 0.5) * g_fContrast + 0.5 + g_fBrightness);
	}

	vColor.xyz = Dither16(vColor.xyz, uv);

	return vColor;
}


// apply saturation/color filter, brightness/contrast and gamma
technique TeqBrSatGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 1, 1);
	}
}

// apply brightness/contrast and gamma
technique TeqBrGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 1, 1);
	}
}

// apply brightness/contrast and saturation/color
technique TeqBrSat
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 0, 1);
	}
}


// apply saturation/color filter and gamma
technique TeqSatGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 1, 0);
	}
}

// apply only gamma
technique TeqGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 1, 0);
	}
}

// apply only brightness/contrast
technique TeqBr
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 0, 1);
	}
}

// apply only saturation/color
technique TeqSat
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 0, 0);
	}
}

// plain copy
technique TeqCopy
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 0, 0);
	}
}
