// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Jason Tuttle/4 Height Blended Materials"
{
	Properties
	{
		[NoScaleOffset]_M1Albedo("M1 - Albedo", 2D) = "white" {}
		[NoScaleOffset]_M1Normal("M1 - Normal", 2D) = "white" {}
		[NoScaleOffset]_M1AORHeightGRoughnessB("M1 - AO(R) Height(G) Roughness(B)", 2D) = "white" {}
		[IntRange]_M1UVTiling("M1 - UV Tiling", Range( 1 , 100)) = 1
		_M1M2BlendStrength("M1 - M2 Blend Strength", Range( 0 , 100)) = 1
		[NoScaleOffset]_M2Albedo("M2 - Albedo", 2D) = "white" {}
		[NoScaleOffset]_M2Normal("M2 - Normal", 2D) = "white" {}
		[NoScaleOffset]_M2AORHeightGRoughnessB("M2 - AO(R) Height(G) Roughness(B)", 2D) = "white" {}
		[IntRange]_M2UVTiling("M2 - UV Tiling", Range( 1 , 100)) = 1
		_M2M3BlendStrength("M2 - M3 Blend Strength", Range( 0 , 100)) = 1
		[NoScaleOffset]_M3Albedo("M3 - Albedo", 2D) = "white" {}
		[NoScaleOffset]_M3Normal("M3 - Normal", 2D) = "white" {}
		[NoScaleOffset]_M3AORHeightGRoughnessB("M3 - AO(R) Height(G) Roughness(B)", 2D) = "white" {}
		[IntRange]_M3UVTiling("M3 - UV Tiling", Range( 1 , 100)) = 1
		_M3M4BlendStrength("M3 - M4 Blend Strength", Range( 0 , 100)) = 1
		[NoScaleOffset]_M4Albedo("M4 - Albedo", 2D) = "white" {}
		[NoScaleOffset]_M4Normal("M4 - Normal", 2D) = "white" {}
		[NoScaleOffset]_M4AORHeightGRoughnessB("M4 - AO(R) Height(G) Roughness(B)", 2D) = "white" {}
		[IntRange]_M4UVTiling("M4 - UV Tiling", Range( 1 , 100)) = 1
		[Toggle]_InvertRoughness("Invert Roughness", Float) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _M1Normal;
		uniform float _M1UVTiling;
		uniform sampler2D _M2Normal;
		uniform float _M2UVTiling;
		uniform sampler2D _M3Normal;
		uniform float _M3UVTiling;
		uniform sampler2D _M4Normal;
		uniform float _M4UVTiling;
		uniform sampler2D _M4AORHeightGRoughnessB;
		uniform float _M3M4BlendStrength;
		uniform sampler2D _M3AORHeightGRoughnessB;
		uniform float _M2M3BlendStrength;
		uniform sampler2D _M2AORHeightGRoughnessB;
		uniform float _M1M2BlendStrength;
		uniform sampler2D _M1Albedo;
		uniform sampler2D _M2Albedo;
		uniform sampler2D _M3Albedo;
		uniform sampler2D _M4Albedo;
		uniform float _Metallic;
		uniform float _InvertRoughness;
		uniform sampler2D _M1AORHeightGRoughnessB;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_7_0 = ( i.uv_texcoord * ( _M1UVTiling + _M1UVTiling ) );
			float2 temp_output_73_0 = ( i.uv_texcoord * ( _M2UVTiling + _M2UVTiling ) );
			float2 temp_output_92_0 = ( i.uv_texcoord * ( _M3UVTiling + _M3UVTiling ) );
			float2 temp_output_133_0 = ( i.uv_texcoord * ( _M4UVTiling + _M4UVTiling ) );
			float4 tex2DNode154 = tex2D( _M4AORHeightGRoughnessB, temp_output_133_0 );
			float HeightMask148 = saturate(pow(((tex2DNode154.g*i.vertexColor.b)*4)+(i.vertexColor.b*2),_M3M4BlendStrength));
			float4 lerpResult152 = lerp( tex2D( _M3Normal, temp_output_92_0 ) , tex2D( _M4Normal, temp_output_133_0 ) , HeightMask148);
			float4 tex2DNode156 = tex2D( _M3AORHeightGRoughnessB, temp_output_92_0 );
			float lerpResult162 = lerp( tex2DNode156.g , tex2DNode154.g , i.vertexColor.b);
			float HeightMask110 = saturate(pow(((lerpResult162*i.vertexColor.g)*4)+(i.vertexColor.g*2),_M2M3BlendStrength));
			float4 lerpResult115 = lerp( tex2D( _M2Normal, temp_output_73_0 ) , lerpResult152 , HeightMask110);
			float4 tex2DNode157 = tex2D( _M2AORHeightGRoughnessB, temp_output_73_0 );
			float lerpResult158 = lerp( tex2DNode157.g , lerpResult162 , i.vertexColor.g);
			float HeightMask36 = saturate(pow(((lerpResult158*i.vertexColor.r)*4)+(i.vertexColor.r*2),_M1M2BlendStrength));
			float4 lerpResult37 = lerp( tex2D( _M1Normal, temp_output_7_0 ) , lerpResult115 , HeightMask36);
			o.Normal = lerpResult37.rgb;
			float HeightMask142 = saturate(pow(((tex2DNode154.g*i.vertexColor.b)*4)+(i.vertexColor.b*2),_M3M4BlendStrength));
			float4 lerpResult150 = lerp( tex2D( _M3Albedo, temp_output_92_0 ) , tex2D( _M4Albedo, temp_output_133_0 ) , HeightMask142);
			float HeightMask112 = saturate(pow(((lerpResult162*i.vertexColor.g)*4)+(i.vertexColor.g*2),_M2M3BlendStrength));
			float4 lerpResult113 = lerp( tex2D( _M2Albedo, temp_output_73_0 ) , lerpResult150 , HeightMask112);
			float HeightMask22 = saturate(pow(((lerpResult158*i.vertexColor.r)*4)+(i.vertexColor.r*2),_M1M2BlendStrength));
			float4 lerpResult24 = lerp( tex2D( _M1Albedo, temp_output_7_0 ) , lerpResult113 , HeightMask22);
			o.Albedo = lerpResult24.rgb;
			o.Metallic = _Metallic;
			float4 tex2DNode97 = tex2D( _M1AORHeightGRoughnessB, temp_output_7_0 );
			float HeightMask144 = saturate(pow(((tex2DNode154.g*i.vertexColor.b)*4)+(i.vertexColor.b*2),_M3M4BlendStrength));
			float lerpResult145 = lerp( tex2DNode156.b , tex2DNode154.b , HeightMask144);
			float HeightMask108 = saturate(pow(((lerpResult162*i.vertexColor.g)*4)+(i.vertexColor.g*2),_M2M3BlendStrength));
			float lerpResult109 = lerp( tex2DNode157.b , lerpResult145 , HeightMask108);
			float HeightMask40 = saturate(pow(((lerpResult158*i.vertexColor.r)*4)+(i.vertexColor.r*2),_M1M2BlendStrength));
			float lerpResult43 = lerp( tex2DNode97.b , lerpResult109 , HeightMask40);
			o.Smoothness = lerp(lerpResult43,( 1.0 - lerpResult43 ),_InvertRoughness);
			float HeightMask149 = saturate(pow(((tex2DNode154.g*i.vertexColor.b)*4)+(i.vertexColor.b*2),_M3M4BlendStrength));
			float lerpResult151 = lerp( tex2DNode156.r , tex2DNode154.r , HeightMask149);
			float HeightMask111 = saturate(pow(((lerpResult162*i.vertexColor.g)*4)+(i.vertexColor.g*2),_M2M3BlendStrength));
			float lerpResult114 = lerp( tex2DNode157.r , lerpResult151 , HeightMask111);
			float HeightMask31 = saturate(pow(((lerpResult158*i.vertexColor.r)*4)+(i.vertexColor.r*2),_M1M2BlendStrength));
			float lerpResult32 = lerp( tex2DNode97.r , lerpResult114 , HeightMask31);
			o.Occlusion = lerpResult32;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
0;23;1920;1099;4602.784;95.97651;3.609998;True;False
Node;AmplifyShaderEditor.RangedFloatNode;130;-2879.158,2848.729;Float;False;Property;_M4UVTiling;M4 - UV Tiling;18;1;[IntRange];Create;True;0;0;False;0;1;0;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2882.066,2133.678;Float;False;Property;_M3UVTiling;M3 - UV Tiling;13;1;[IntRange];Create;True;0;0;False;0;1;0;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-3446.359,1757.626;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-2605.796,2126.678;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2891.053,1409.327;Float;False;Property;_M2UVTiling;M2 - UV Tiling;8;1;[IntRange];Create;True;0;0;False;0;1;0;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;-2602.888,2841.729;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;102;-2148.749,1824.236;Float;False;346.502;671.5033;Material 3;3;95;156;96;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-2454.931,2818.28;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-2607.688,1402.327;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-2449.754,2103.23;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;155;-2157.098,2534.899;Float;False;370.1748;694.8123;Material 4;3;138;137;154;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;154;-2126.055,3004.702;Float;True;Property;_M4AORHeightGRoughnessB;M4 - AO(R) Height(G) Roughness(B);17;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;156;-2122.244,2283.269;Float;True;Property;_M3AORHeightGRoughnessB;M3 - AO(R) Height(G) Roughness(B);12;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-2895.371,703.0226;Float;False;Property;_M1UVTiling;M1 - UV Tiling;3;1;[IntRange];Create;True;0;0;False;0;1;0;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;-1594.829,3336.65;Float;False;Property;_M3M4BlendStrength;M3 - M4 Blend Strength;14;0;Create;True;0;0;False;0;1;1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-2446.255,1378.879;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;141;-1533.753,3146.779;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;99;-2162.057,1098.501;Float;False;358.5937;693.1306;Material 2;3;20;18;157;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;107;-878.1338,1275.341;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;162;-889.1004,1568.808;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;157;-2130.272,1557.416;Float;True;Property;_M2AORHeightGRoughnessB;M2 - AO(R) Height(G) Roughness(B);7;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HeightMapBlendNode;144;-840.6897,3606.095;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-2616.621,696.0228;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-933.7994,1464.188;Float;False;Property;_M2M3BlendStrength;M2 - M3 Blend Strength;9;0;Create;True;0;0;False;0;1;1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;145;-614.2891,3557.982;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-2455.189,667.1836;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;139;-894.374,2644.467;Float;False;469.3699;254.57;Albedo Blend;1;142;;1,1,1,1;0;0
Node;AmplifyShaderEditor.HeightMapBlendNode;108;-221.6862,2278.692;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;100;-2160.767,376.9935;Float;False;348.9063;692.868;Material 1;2;1;97;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-34.4155,645.7979;Float;False;Property;_M1M2BlendStrength;M1 - M2 Blend Strength;4;0;Create;True;0;0;False;0;1;1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;23;26.18532,472.6817;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;158;68.33146,769.2463;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;86;685.3934,945.1833;Float;False;460.3998;254.1141;Roughness Blend;2;43;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.HeightMapBlendNode;40;735.3933,1043.298;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.HeightMapBlendNode;142;-844.3738,2740.656;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;138;-2111.944,2583.269;Float;True;Property;_M4Albedo;M4 - Albedo;15;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;97;-2127.114,841.8272;Float;True;Property;_M1AORHeightGRoughnessB;M1 - AO(R) Height(G) Roughness(B);2;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;96;-2098.883,2075.879;Float;True;Property;_M3Normal;M3 - Normal;11;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;95;-2101.128,1874.236;Float;True;Property;_M3Albedo;M3 - Albedo;10;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HeightMapBlendNode;148;-831.4302,3319.363;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;137;-2109.478,2796.415;Float;True;Property;_M4Normal;M4 - Normal;16;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HeightMapBlendNode;149;-835.9651,3033.478;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;109;4.714139,2230.578;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;152;-611.0746,3272.938;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;18;-2108.063,1348.791;Float;True;Property;_M2Normal;M2 - Normal;6;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;151;-607.0294,2987.052;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HeightMapBlendNode;110;-212.4265,1991.96;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;43;961.7931,995.1833;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HeightMapBlendNode;111;-216.9616,1706.074;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;-2108.723,1148.501;Float;True;Property;_M2Albedo;M2 - Albedo;5;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;150;-609.0031,2694.467;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.HeightMapBlendNode;112;-225.3702,1415.633;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;85;685.1929,643.5845;Float;False;454.3548;252.4248;Normal Blend;2;37;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;115;7.928623,1945.535;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;47;1431.24,783.0109;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-2108.922,633.478;Float;True;Property;_M1Normal;M1 - Normal;1;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;113;10.00019,1367.063;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.HeightMapBlendNode;22;717.9343,167.2929;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2110.016,426.9937;Float;True;Property;_M1Albedo;M1 - Albedo;0;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HeightMapBlendNode;31;721.1978,447.0295;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;114;11.97382,1659.649;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HeightMapBlendNode;36;735.1927,740.0093;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;32;950.1326,400.6046;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;24;953.304,118.7228;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;37;955.5474,693.5845;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;45;1365.46,388.2441;Float;False;Property;_Metallic;Metallic;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;68;1585.292,557.7135;Float;False;Property;_InvertRoughness;Invert Roughness;19;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1817.635,383.2155;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Jason Tuttle/4 Height Blended Materials;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;105;-262.4267,1895.534;Float;False;454.3548;252.4248;Normal Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;104;-266.9619,1609.649;Float;False;462.935;252.4249;AO Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;83;667.9343,68.72282;Float;False;469.3699;254.57;Albedo Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;84;671.1978,350.6046;Float;False;462.935;252.4249;AO Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;106;-275.3704,1317.063;Float;False;469.3699;254.57;Albedo Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;147;-885.9656,2937.052;Float;False;462.935;252.4249;AO Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;103;-271.6863,2180.577;Float;False;460.3998;254.1141;Roughness Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;143;-890.6899,3507.981;Float;False;460.3998;254.1141;Roughness Blend;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;146;-881.4303,3222.938;Float;False;454.3548;252.4248;Normal Blend;0;;1,1,1,1;0;0
WireConnection;89;0;88;0
WireConnection;89;1;88;0
WireConnection;131;0;130;0
WireConnection;131;1;130;0
WireConnection;133;0;5;0
WireConnection;133;1;131;0
WireConnection;72;0;70;0
WireConnection;72;1;70;0
WireConnection;92;0;5;0
WireConnection;92;1;89;0
WireConnection;154;1;133;0
WireConnection;156;1;92;0
WireConnection;73;0;5;0
WireConnection;73;1;72;0
WireConnection;162;0;156;2
WireConnection;162;1;154;2
WireConnection;162;2;141;3
WireConnection;157;1;73;0
WireConnection;144;0;154;2
WireConnection;144;1;141;3
WireConnection;144;2;140;0
WireConnection;62;0;61;0
WireConnection;62;1;61;0
WireConnection;145;0;156;3
WireConnection;145;1;154;3
WireConnection;145;2;144;0
WireConnection;7;0;5;0
WireConnection;7;1;62;0
WireConnection;108;0;162;0
WireConnection;108;1;107;2
WireConnection;108;2;116;0
WireConnection;158;0;157;2
WireConnection;158;1;162;0
WireConnection;158;2;107;2
WireConnection;40;0;158;0
WireConnection;40;1;23;1
WireConnection;40;2;25;0
WireConnection;142;0;154;2
WireConnection;142;1;141;3
WireConnection;142;2;140;0
WireConnection;138;1;133;0
WireConnection;97;1;7;0
WireConnection;96;1;92;0
WireConnection;95;1;92;0
WireConnection;148;0;154;2
WireConnection;148;1;141;3
WireConnection;148;2;140;0
WireConnection;137;1;133;0
WireConnection;149;0;154;2
WireConnection;149;1;141;3
WireConnection;149;2;140;0
WireConnection;109;0;157;3
WireConnection;109;1;145;0
WireConnection;109;2;108;0
WireConnection;152;0;96;0
WireConnection;152;1;137;0
WireConnection;152;2;148;0
WireConnection;18;1;73;0
WireConnection;151;0;156;1
WireConnection;151;1;154;1
WireConnection;151;2;149;0
WireConnection;110;0;162;0
WireConnection;110;1;107;2
WireConnection;110;2;116;0
WireConnection;43;0;97;3
WireConnection;43;1;109;0
WireConnection;43;2;40;0
WireConnection;111;0;162;0
WireConnection;111;1;107;2
WireConnection;111;2;116;0
WireConnection;20;1;73;0
WireConnection;150;0;95;0
WireConnection;150;1;138;0
WireConnection;150;2;142;0
WireConnection;112;0;162;0
WireConnection;112;1;107;2
WireConnection;112;2;116;0
WireConnection;115;0;18;0
WireConnection;115;1;152;0
WireConnection;115;2;110;0
WireConnection;47;0;43;0
WireConnection;12;1;7;0
WireConnection;113;0;20;0
WireConnection;113;1;150;0
WireConnection;113;2;112;0
WireConnection;22;0;158;0
WireConnection;22;1;23;1
WireConnection;22;2;25;0
WireConnection;1;1;7;0
WireConnection;31;0;158;0
WireConnection;31;1;23;1
WireConnection;31;2;25;0
WireConnection;114;0;157;1
WireConnection;114;1;151;0
WireConnection;114;2;111;0
WireConnection;36;0;158;0
WireConnection;36;1;23;1
WireConnection;36;2;25;0
WireConnection;32;0;97;1
WireConnection;32;1;114;0
WireConnection;32;2;31;0
WireConnection;24;0;1;0
WireConnection;24;1;113;0
WireConnection;24;2;22;0
WireConnection;37;0;12;0
WireConnection;37;1;115;0
WireConnection;37;2;36;0
WireConnection;68;0;43;0
WireConnection;68;1;47;0
WireConnection;0;0;24;0
WireConnection;0;1;37;0
WireConnection;0;3;45;0
WireConnection;0;4;68;0
WireConnection;0;5;32;0
ASEEND*/
//CHKSM=0BFC3BAC44BBAE057F706D2A173286EAB7666F19