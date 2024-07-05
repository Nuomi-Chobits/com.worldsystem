// Made with Amplify Shader Editor v1.9.3.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "EXLit"
{
	Properties
	{

		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[EnumGroup(RenderStateGroup2, _SENIOR, SurfaceOptions, _SurfaceOptions)]RenderStateGroup2("表面选项/渲染状态", Vector) = (0,0,0,0)
		[LogicalSubKeywordEnum(RenderStateGroup2_SurfaceOptions,_SAMPLE_COMMON,_SAMPLE_NOISETILING,_SAMPLE_HEXAGONTILING,_SAMPLE_ONESAMPLEONTILING)] Sample_Enum("关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复", Float) = 0
		[LogicalSub(RenderStateGroup2_SAMPLE_NOISETILING or RenderStateGroup2_SAMPLE_HEXAGONTILING indent)]_ScaleOrRotate("缩放/旋转", Range( -1 , 1)) = 0.3
		[EnumGroup(ShaderModelGroup1, _SENIOR,PBR_senior disable_WindEnabled_Enum, _SHADER_PBR,PLANT_senior disable_DetailGroup0 disable_ClearCoatGroup disable_ParallaxGroup0, _SHADER_PLANT)] ShaderModelGroup1("通用PBR/场景-植物/着色器模型", Vector) = (0,0,0,0)
		[Title(ShaderModelGroup1, Albedo Alpha)][MainTexture][LogicalTex(ShaderModelGroup1, true, RGB_A, _)]_BaseMap("基础贴图", 2D) = "white" {}
		[MainColor][LogicalSub(ShaderModelGroup1)]_BaseColor("基础颜色", Color) = (1,1,1,1)
		[LogicalSub(ShaderModelGroup1)]_SpecColor("高光颜色", Color) = (1,1,1,1)
		[Title(ShaderModelGroup1, Normal Roughness Occlusion)][LogicalTex(ShaderModelGroup1, false, RG_B_A, _)]_NRAMap("NRA贴图#通用PBR:(法线, 粗糙度, AO)#场景-植物:(法线, 粗糙度, AO)", 2D) = "bump" {}
		[LogicalSubToggle(ShaderModelGroup1_senior, EFFECT_BACKSIDE_NORMALS)] FlipBackNormal_On("翻转背面法线", Float) = 0
		[LogicalSub(ShaderModelGroup1)]_BumpScale("法线强度", Range( -1 , 1)) = 0
		[LogicalSubToggle(ShaderModelGroup1, _OCCLUSION)] Occlusion_On("环境光遮蔽", Float) = 1
		[LogicalSub(ShaderModelGroup1_OCCLUSION indent)]_OcclusionStrength("环境光遮蔽贴图强度", Range( -1 , 1)) = 0
		[LogicalSub(ShaderModelGroup1_OCCLUSION indent)]_HorizonOcclusion("地平线遮蔽(Horizon)强度", Range( -0.5 , 0.5)) = 0
		[LogicalTitle(ShaderModelGroup1_SHADER_PBR, Emission Metallic)][LogicalTitle(ShaderModelGroup1_SHADER_PLANT, Emission SubSurfaceWeight)][LogicalTex(ShaderModelGroup1, false, RGB_A, _)]_EmissionMixMap("自发光混合贴图#通用PBR:(自发光, 金属度)#场景-植物:(自发光, 次表面强度)", 2D) = "black" {}
		[LogicalSubToggle(ShaderModelGroup1, _customreflect)] _CustomReflect("自定义反射", Float) = 0
		[LogicalLineTex(ShaderModelGroup1_customreflect indent)]_CustomReflectMap("自定义反射贴图", CUBE) = "white" {}
		[LogicalSub(ShaderModelGroup1_SHADER_PLANT)]_SubsurfaceColor("散射颜色", Color) = (1,1,1,1)
		[LogicalSub(ShaderModelGroup1_SHADER_PLANT)]_SubsurfaceIndirect("间接光散射", Range( 0 , 1)) = 0.25
		[LogicalSub(ShaderModelGroup1_SHADER_PBR or ShaderModelGroup1_SHADER_ALPHATEST)]_Metallic("金属度", Range( -1 , 1)) = 0
		[HDR][LogicalSub(ShaderModelGroup1)]_EmissionColor("自发光颜色", Color) = (1,1,1,1)
		[LogicalEmission(ShaderModelGroup1_SENIOR)]EmissionGI_GUI("自发光GI", Float) = 0
		[LogicalTitle(ShaderModelGroup1_ExtraMixMap_Display, Extra Mixed)][LogicalSubToggle(ShaderModelGroup1, _ExtraMixMap_Display)]ExtraMixMap_Display("显示额外混合贴图", Float) = 0
		[LogicalTex(ShaderModelGroup1_ExtraMixMap_Display, false, R_G_B_A, _)]_ExtraMixMap("额外混合贴图", 2D) = "black" {}
		[LogicalSubKeywordEnum(ShaderModelGroup1_SHADER_PLANT,_WINDQUALITY_NONE,_WINDQUALITY_FASTEST,_WINDQUALITY_FAST,_WINDQUALITY_BETTER,_WINDQUALITY_BEST,_WINDQUALITY_PALM)] WindEnabled_Enum("关闭/最快/快速/更好/最好/棕榈树/风力", Float) = 1
		[EnumGroup(HoudiniVATGroup0, _SENIOR, Off, _,HoudiniVATSoft, _HOUDINI_VAT_SOFT)] HoudiniVATGroup0("禁用/软体动画/Houdini顶点动画贴图(VAT)", Vector) = (0,0,0,0)
		[LogicalTex(HoudiniVATGroup0_HOUDINI_VAT_SOFT, false, RGB_A, _)]_PositionVATMap("VAT位置贴图", 2D) = "white" {}
		[LogicalTex(HoudiniVATGroup0_HOUDINI_VAT_SOFT, false, RGB_A, _)]_RotateVATMap("VAT旋转贴图", 2D) = "white" {}
		[LogicalSubToggle(HoudiniVATGroup0_HOUDINI_VAT_SOFT, _)]_IsPosTexHDR("位置贴图使用HDR", Float) = 1
		[LogicalSubToggle(HoudiniVATGroup0_HOUDINI_VAT_SOFT, _)]_AutoPlay("自动播放", Float) = 1
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_DisplayFrame("显示帧", Float) = 1
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_PlaySpeed("播放速度", Float) = 1
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_AnimatorStrength("动画幅度", Float) = 1
		[Title(HoudiniVATGroup0_HOUDINI_VAT_SOFT, Houdini VAT Data)][LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_HoudiniFPS("Houdini FPS", Float) = 24
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_FrameCount("Frame Count", Float) = 0
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_BoundMax_X("Bound Max X", Float) = 0
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_BoundMax_Y("Bound Max Y", Float) = 0
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_BoundMax_Z("Bound Max Z", Float) = 0
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_BoundMin_X("Bound Min X", Float) = 0
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_BoundMin_Y("Bound Min Y", Float) = 0
		[LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT)]_BoundMin_Z("Bound Min Z", Float) = 0
		[EnumGroup(ParallaxGroup0, _SENIOR,Off disable_ParallaxSource_Enum, _PARALLAXMAP_OFF,ParallaxOffset, _PARALLAXMAP)] ParallaxGroup0("禁用/视差偏移/视差(UV)", Vector) = (0,0,0,0)
		[LogicalTex(ParallaxGroup0_PARALLAXMAP and ParallaxGroup0_USE_PARALLAXMAP_PARALLAX, false, RGB_A, _)]_HeightMap("视差贴图(高度)", 2D) = "white" {}
		[LogicalSub(ParallaxGroup0_PARALLAXMAP)]_Parallax("视差强度", Range( 0 , 0.05)) = 0
		[EnumGroup(DetailGroup0, _SENIOR,Off, _,Detail1Multi, _DETAIL,Detail2Multi, _DETAIL_2MULTI,Detail4Multi, _DETAIL_4MULTI)] DetailGroup0("禁用/一层细节/两层细节/四层细节/细节", Vector) = (0,0,0,0)
		[LogicalTex(DetailGroup0_DETAIL or DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _)]_DetailMap0("1-细节贴图", 2D) = "bump" {}
		[LogicalSub(DetailGroup0_DETAIL or DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI)]_DetailOcclusionStrength0("1-细节遮蔽强度", Range( 0 , 2)) = 1
		[LogicalSub(DetailGroup0_DETAIL or DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI)]_DetailNormalScale0("1-细节法线强度", Range( 0 , 2)) = 1
		[LogicalTitle(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI, Detail Two Layer)][LogicalTex(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _)]_DetailMap1("2-细节贴图", 2D) = "bump" {}
		[LogicalSub(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI)]_DetailNormalScale1("2-细节法线强度", Range( 0 , 2)) = 1
		[LogicalSub(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI)]_DetailOcclusionStrength1("2-细节遮蔽强度", Range( 0 , 2)) = 1
		[LogicalTitle(DetailGroup0_DETAIL_4MULTI, Detail Three Layer)][LogicalTex(DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _)]_DetailMap2("3-细节贴图", 2D) = "bump" {}
		[LogicalSub(DetailGroup0_DETAIL_4MULTI)]_DetailOcclusionStrength2("3-细节遮蔽强度", Range( 0 , 2)) = 1
		[LogicalSub(DetailGroup0_DETAIL_4MULTI)]_DetailNormalScale2("3-细节法线强度", Range( 0 , 2)) = 1
		[LogicalTitle(DetailGroup0_DETAIL_4MULTI, Detail Four Layer)][LogicalTex(DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _)]_DetailMap3("4-细节贴图", 2D) = "bump" {}
		[LogicalSub(DetailGroup0_DETAIL_4MULTI)]_DetailOcclusionStrength3("4-细节遮蔽强度", Range( 0 , 2)) = 1
		[LogicalSub(DetailGroup0_DETAIL_4MULTI)]_DetailNormalScale3("4-细节法线强度", Range( 0 , 2)) = 1
		[EnumGroup(ClearCoatGroup0, _SENIOR, Off disable_ClearCoatSource_Enum, _,On, _CLEARCOAT)] ClearCoatGroup0("禁用/启用/清漆", Vector) = (0,0,0,0)
		[LogicalTex(ClearCoatGroup0_CLEARCOAT, false, R_G_B_A, _)]_ClearCoatMap("清漆贴图", 2D) = "white" {}
		[LogicalSub(ClearCoatGroup0_CLEARCOAT)]_ClearCoatMask("清漆遮罩", Range( -1 , 1)) = 0
		[LogicalSub(ClearCoatGroup0_CLEARCOAT)]_ClearCoatSmoothness("清漆粗糙度", Range( -1 , 1)) = 0
		[EnumGroup(HueVariationGroup0, _SENIOR,Off, _,On, EFFECT_HUE_VARIATION)] HueVariationGroup0("禁用/开启/色调变体", Vector) = (0,0,0,0)
		[LogicalSub(HueVariationGroup0EFFECT_HUE_VARIATION)]_HueVariationColor("色调变体颜色", Color) = (1,0.5,0,0.1019608)
		[LogicalKeywordList(_)]_LogicalKeywordList("LogicalKeywordList", Float) = 0


		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Unlit" }

		Cull Back
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForwardOnly" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_SRP_VERSION 140009


			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 RenderStateGroup2;
			float4 _BaseMap_ST;
			float4 _EmissionColor;
			float4 _HueVariationColor;
			float4 _SubsurfaceColor;
			float4 _SpecColor;
			float _ClearCoatSmoothness;
			float _ClearCoatMask;
			float _OcclusionStrength;
			float _Metallic;
			float _DetailOcclusionStrength2;
			float _HorizonOcclusion;
			float EmissionGI_GUI;
			float _SubsurfaceIndirect;
			float ExtraMixMap_Display;
			float _LogicalKeywordList;
			float _ScaleOrRotate;
			float _HoudiniFPS;
			float _BoundMin_Z;
			float _BoundMin_Y;
			float _BoundMin_X;
			float _DetailNormalScale2;
			float _DetailOcclusionStrength3;
			float _DetailNormalScale3;
			float _DetailOcclusionStrength0;
			float _DetailNormalScale0;
			float _DetailOcclusionStrength1;
			float _DetailNormalScale1;
			float _Parallax;
			float _AnimatorStrength;
			float _DisplayFrame;
			float _AutoPlay;
			float _IsPosTexHDR;
			float _FrameCount;
			float _BoundMax_X;
			float _BoundMax_Y;
			float _BoundMax_Z;
			float _PlaySpeed;
			float _BumpScale;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3

			

			#pragma multi_compile_fragment _ DEBUG_DISPLAY

			

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_UNLIT

			
			#if ASE_SRP_VERSION >=140007
            #pragma multi_compile _ _FORWARD_PLUS
			#endif
		
			
			
			#if ASE_SRP_VERSION >=140007
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Debug/Debugging3D.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceData.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif


			#if defined(LIGHTMAP_ON)
				#define DECLARE_LIGHTMAP_OR_SH_FOG(staticLightmapUV_fogFactor, vertexSH_fogFactor, index) float4 staticLightmapUV_fogFactor : TEXCOORD##index
			#else
				#define DECLARE_LIGHTMAP_OR_SH_FOG(staticLightmapUV_fogFactor, vertexSH_fogFactor, index) float4 vertexSH_fogFactor : TEXCOORD##index
			#endif

			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/BaseFunctionLibrary.hlsl"
			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/TextureFunctionLibrary.hlsl"
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local_fragment   _DETAIL _DETAIL_2MULTI _DETAIL_4MULTI
			#pragma shader_feature_local   EFFECT_HUE_VARIATION
			#pragma shader_feature_local   _CLEARCOAT
			#pragma shader_feature_local_fragment _OCCLUSION
			#pragma shader_feature_local _SHADER_PBR _SHADER_PLANT
			#pragma shader_feature_local_fragment _SAMPLE_COMMON _SAMPLE_NOISETILING _SAMPLE_HEXAGONTILING _SAMPLE_ONESAMPLEONTILING
			#pragma shader_feature_local_vertex _WINDQUALITY_NONE _WINDQUALITY_FASTEST _WINDQUALITY_FAST _WINDQUALITY_BETTER _WINDQUALITY_BEST _WINDQUALITY_PALM
			#pragma shader_feature_local  
			#pragma shader_feature_local_vertex   _HOUDINI_VAT_SOFT
			#pragma shader_feature_local_fragment _PARALLAXMAP_OFF _PARALLAXMAP
			#pragma shader_feature_local EFFECT_BACKSIDE_NORMALS


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					float4 shadowCoord : TEXCOORD0;
				#endif
				#if defined(ASE_FOG) || defined(REQUIRE_BAKEDGI)
					DECLARE_LIGHTMAP_OR_SH_FOG(staticLightmapUV_fogFactor, vertexSH_fogFactor, 1);
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			float4 _BaseMap_TexelSize;
			float4 _BaseMap_MipInfo;

			sampler2D _DetailMap3;
			sampler2D _DetailMap0;
			sampler2D _DetailMap1;
			sampler2D _DetailMap2;
			sampler2D _PositionVATMap;
			sampler2D _RotateVATMap;
			samplerCUBE _CustomReflectMap;
			sampler2D _ClearCoatMap;
			sampler2D _EmissionMixMap;
			sampler2D _ExtraMixMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;
			sampler2D _NRAMap;


			float3 TransformObjectToWorldNormal_Ref33_g6967( float3 normalOS )
			{
				return TransformObjectToWorldNormal(normalOS,false);
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 SampleSHVertex_Ref376_g6964( float3 normalWS )
			{
				return SampleSHVertex(normalWS);
			}
			
			float ComputeFogFactor_Ref381_g6964( float4 positionCS )
			{
				return ComputeFogFactor(positionCS.z);
			}
			
			float4 GetShadowCoord_Ref384_g6964( float4 positionCS, float3 positionWS )
			{
				#if defined(_MAIN_LIGHT_SHADOWS_SCREEN) && !defined(_SURFACE_TYPE_TRANSPARENT)
				    return ComputeScreenPos(positionCS);
				#else
				    return TransformWorldToShadowCoord(positionWS);
				#endif
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 TransformWorldToTangentDir_Ref133_g6965( float3 directionWS, float3x3 TBN )
			{
				return TransformWorldToTangentDir(directionWS, TBN);
			}
			
			float2 IterativeParallaxLegacy1_g6991( float height, float2 UVs, float2 plane, float refp, float scale )
			{
				UVs += plane * scale * refp;
				UVs += (height - 1) * plane * scale;
				return UVs;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 temp_output_31_0_g6967 = ( v.normalOS + float3( 0,0,0 ) );
				float3 normalOS33_g6967 = temp_output_31_0_g6967;
				float3 localTransformObjectToWorldNormal_Ref33_g6967 = TransformObjectToWorldNormal_Ref33_g6967( normalOS33_g6967 );
				float3 normalizeResult140_g6967 = ASESafeNormalize( localTransformObjectToWorldNormal_Ref33_g6967 );
				float3 temp_output_515_34_g6964 = normalizeResult140_g6967;
				float3 VertexNormalWS314_g6964 = temp_output_515_34_g6964;
				float3 normalWS376_g6964 = VertexNormalWS314_g6964;
				float3 localSampleSHVertex_Ref376_g6964 = SampleSHVertex_Ref376_g6964( normalWS376_g6964 );
				
				float localPosition1_g6976 = ( 0.0 );
				float localGetPositionTransformSpaceFromObject1_g6975 = ( 0.0 );
				float3 temp_output_14_0_g6968 = ( v.positionOS.xyz + float3( 0,0,0 ) );
				float3 positionOS1_g6975 = temp_output_14_0_g6968;
				Position position1_g6975 =(Position)0;
				GetPositionTransformSpaceFromObject_float( positionOS1_g6975 , position1_g6975 );
				Position position1_g6976 =(Position)position1_g6975;
				float3 OS1_g6976 = float3( 0,0,0 );
				float3 WS1_g6976 = float3( 0,0,0 );
				float3 VS1_g6976 = float3( 0,0,0 );
				float4 CS1_g6976 = float4( 0,0,0,0 );
				float4 NDC1_g6976 = float4( 0,0,0,0 );
				float3 SS1_g6976 = float3( 0,0,0 );
				float4 DS1_g6976 = float4( 0,0,0,0 );
				float3 LS1_g6976 = float3( 0,0,0 );
				float4 SC1_g6976 = float4( 0,0,0,0 );
				Position_float( position1_g6976 , OS1_g6976 , WS1_g6976 , VS1_g6976 , CS1_g6976 , NDC1_g6976 , SS1_g6976 , DS1_g6976 , LS1_g6976 , SC1_g6976 );
				float4 vertexPositionCS382_g6964 = CS1_g6976;
				float4 positionCS381_g6964 = vertexPositionCS382_g6964;
				float localComputeFogFactor_Ref381_g6964 = ComputeFogFactor_Ref381_g6964( positionCS381_g6964 );
				
				float4 positionCS384_g6964 = vertexPositionCS382_g6964;
				float3 temp_output_345_7_g6964 = WS1_g6976;
				float3 vertexPositionWS386_g6964 = temp_output_345_7_g6964;
				float3 positionWS384_g6964 = vertexPositionWS386_g6964;
				float4 localGetShadowCoord_Ref384_g6964 = GetShadowCoord_Ref384_g6964( positionCS384_g6964 , positionWS384_g6964 );
				
				float4 temp_output_478_313 = vertexPositionCS382_g6964;
				
				float2 break242 = ( ( v.ase_texcoord.xy * _BaseMap_ST.xy ) + _BaseMap_ST.zw );
				float vertexToFrag237 = break242.x;
				o.ase_texcoord2.x = vertexToFrag237;
				float vertexToFrag236 = break242.y;
				o.ase_texcoord2.y = vertexToFrag236;
				float3 normalizeResult129_g6964 = ASESafeNormalize( ( _WorldSpaceCameraPos - vertexPositionWS386_g6964 ) );
				float3 temp_output_43_0_g6965 = normalizeResult129_g6964;
				float3 directionWS133_g6965 = temp_output_43_0_g6965;
				float3 temp_output_43_0_g6966 = ( v.ase_tangent.xyz + float3( 0,0,0 ) );
				float3 objToWorldDir42_g6966 = mul( GetObjectToWorldMatrix(), float4( temp_output_43_0_g6966, 0 ) ).xyz;
				float3 normalizeResult128_g6966 = ASESafeNormalize( objToWorldDir42_g6966 );
				float3 VertexTangentlWS474_g6964 = normalizeResult128_g6966;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 normalizeResult473_g6964 = ASESafeNormalize( ( cross( VertexNormalWS314_g6964 , VertexTangentlWS474_g6964 ) * ase_vertexTangentSign ) );
				float3 VertexBitangentWS476_g6964 = normalizeResult473_g6964;
				float3x3 temp_output_103_0_g6965 = float3x3(VertexTangentlWS474_g6964, VertexBitangentWS476_g6964, VertexNormalWS314_g6964);
				float3x3 TBN133_g6965 = temp_output_103_0_g6965;
				float3 localTransformWorldToTangentDir_Ref133_g6965 = TransformWorldToTangentDir_Ref133_g6965( directionWS133_g6965 , TBN133_g6965 );
				float3 normalizeResult132_g6965 = ASESafeNormalize( localTransformWorldToTangentDir_Ref133_g6965 );
				float3 break336_g6964 = normalizeResult132_g6965;
				float vertexToFrag264_g6964 = break336_g6964.x;
				o.ase_texcoord2.z = vertexToFrag264_g6964;
				float vertexToFrag337_g6964 = break336_g6964.y;
				o.ase_texcoord2.w = vertexToFrag337_g6964;
				float vertexToFrag338_g6964 = break336_g6964.z;
				o.ase_texcoord3.x = vertexToFrag338_g6964;
				
				float3 break141_g6964 = VertexTangentlWS474_g6964;
				float vertexToFrag326_g6964 = break141_g6964.x;
				o.ase_texcoord3.y = vertexToFrag326_g6964;
				float vertexToFrag327_g6964 = break141_g6964.y;
				o.ase_texcoord3.z = vertexToFrag327_g6964;
				float vertexToFrag328_g6964 = break141_g6964.z;
				o.ase_texcoord3.w = vertexToFrag328_g6964;
				float3 break148_g6964 = VertexBitangentWS476_g6964;
				float vertexToFrag329_g6964 = break148_g6964.x;
				o.ase_texcoord4.x = vertexToFrag329_g6964;
				float vertexToFrag330_g6964 = break148_g6964.y;
				o.ase_texcoord4.y = vertexToFrag330_g6964;
				float vertexToFrag331_g6964 = break148_g6964.z;
				o.ase_texcoord4.z = vertexToFrag331_g6964;
				float3 break138_g6964 = VertexNormalWS314_g6964;
				float vertexToFrag323_g6964 = break138_g6964.x;
				o.ase_texcoord4.w = vertexToFrag323_g6964;
				float vertexToFrag324_g6964 = break138_g6964.y;
				o.ase_texcoord5.x = vertexToFrag324_g6964;
				float vertexToFrag325_g6964 = break138_g6964.z;
				o.ase_texcoord5.y = vertexToFrag325_g6964;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;

				//接口
				float2 StaticLightmapUV = (v.ase_texcoord1.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 VertexSH = localSampleSHVertex_Ref376_g6964;
				#ifdef ASE_FOG
					float FogFactor = localComputeFogFactor_Ref381_g6964;
				#else
					float FogFactor = 0;
				#endif
				float4 ShadowCoord = localGetShadowCoord_Ref384_g6964;


				//输出,规范:此处不允许做任何计算仅允许输出
				#if defined(ASE_FOG) || defined(REQUIRE_BAKEDGI)
					#if defined(LIGHTMAP_ON)
						o.staticLightmapUV_fogFactor = float4(StaticLightmapUV,0,FogFactor);
					#else
						o.vertexSH_fogFactor = float4(VertexSH,FogFactor);
					#endif
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					o.shadowCoord = ShadowCoord;
				#endif
			
				o.positionCS = temp_output_478_313;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN
				#ifdef _WRITE_RENDERING_LAYERS
				, out float4 outRenderingLayers : SV_Target1
				#endif
				, bool ase_vface : SV_IsFrontFace ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				/*ase_local_var:StaticLightmapUV*/float2 StaticLightmapUV = 0;
				/*ase_local_var:VertexSH*/half3 VertexSH = 0;
				/*ase_local_var:FogFactor*/float FogFactor = 0;
				/*ase_local_var:ShadowCoords*/float4 ShadowCoords = 0;
				/*ase_local_var:PositionDS*/float4 PositionDS = IN.positionCS;

				//初始化
				//ShadowCoords的初始化因为需要worldposition,已将将代码移至ASE中
				#if defined(REQUIRE_BAKEDGI) || defined(ASE_FOG)
					#if defined(LIGHTMAP_ON)
						StaticLightmapUV = IN.staticLightmapUV_fogFactor.xy;
						FogFactor = IN.staticLightmapUV_fogFactor.w;
					#else
						VertexSH = IN.vertexSH_fogFactor.xyz;
						FogFactor = IN.vertexSH_fogFactor.w;
					#endif
				#endif

				float vertexToFrag237 = IN.ase_texcoord2.x;
				float vertexToFrag236 = IN.ase_texcoord2.y;
				float2 appendResult238 = (float2(vertexToFrag237 , vertexToFrag236));
				float2 uv_primitive310 = appendResult238;
				float4 tex2DNode94 = tex2D( _HeightMap, uv_primitive310 );
				float2 temp_output_3_0_g2109 = uv_primitive310;
				float2 uv2_g2109 = temp_output_3_0_g2109;
				sampler2D tex2_g2109 = _HeightMap;
				float _ScaleOrRotate154 = _ScaleOrRotate;
				float simpleNoise1_g2109 = SimpleNoise( temp_output_3_0_g2109*_ScaleOrRotate154 );
				simpleNoise1_g2109 = simpleNoise1_g2109*2 - 1;
				float noise2_g2109 = simpleNoise1_g2109;
				float4 localSampleSupportNoTileing_twoSample2_g2109 = SampleSupportNoTileing_twoSample( uv2_g2109 , tex2_g2109 , noise2_g2109 );
				float2 uv1_g2108 = uv_primitive310;
				sampler2D tex1_g2108 = _HeightMap;
				float scaleOrRotate1_g2108 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g2108 = SampleSupportNoTileing_HexagonSample( uv1_g2108 , tex1_g2108 , scaleOrRotate1_g2108 );
				float2 uv1_g2110 = uv_primitive310;
				sampler2D tex1_g2110 = _HeightMap;
				float2 positionDSxy1_g2110 = IN.positionCS.xy;
				float4 localSampleSupportNoTileing_OneSample1_g2110 = SampleSupportNoTileing_OneSample( uv1_g2110 , tex1_g2110 , positionDSxy1_g2110 );
				#if defined(_SAMPLE_COMMON)
				float staticSwitch332 = ( ( tex2DNode94.r + tex2DNode94.g + tex2DNode94.b + tex2DNode94.a ) / 4.0 );
				#elif defined(_SAMPLE_NOISETILING)
				float staticSwitch332 = (localSampleSupportNoTileing_twoSample2_g2109).x;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_HexagonSample1_g2108).x;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_OneSample1_g2110).x;
				#else
				float staticSwitch332 = 0.0;
				#endif
				float height308 = staticSwitch332;
				float height1_g6991 = height308;
				float2 UVs1_g6991 = uv_primitive310;
				float vertexToFrag264_g6964 = IN.ase_texcoord2.z;
				float vertexToFrag337_g6964 = IN.ase_texcoord2.w;
				float vertexToFrag338_g6964 = IN.ase_texcoord3.x;
				float3 appendResult340_g6964 = (float3(vertexToFrag264_g6964 , vertexToFrag337_g6964 , vertexToFrag338_g6964));
				float3 normalizeResult451_g6964 = normalize( appendResult340_g6964 );
				float3 viewDirTS311 = normalizeResult451_g6964;
				float3 break6_g6991 = viewDirTS311;
				float2 appendResult5_g6991 = (float2(break6_g6991.x , break6_g6991.y));
				float2 plane1_g6991 = ( appendResult5_g6991 / break6_g6991.z );
				float refp1_g6991 = 0.5;
				float scale1_g6991 = _Parallax;
				float2 localIterativeParallaxLegacy1_g6991 = IterativeParallaxLegacy1_g6991( height1_g6991 , UVs1_g6991 , plane1_g6991 , refp1_g6991 , scale1_g6991 );
				#if defined(_PARALLAXMAP_OFF)
				float2 staticSwitch92 = uv_primitive310;
				#elif defined(_PARALLAXMAP)
				float2 staticSwitch92 = localIterativeParallaxLegacy1_g6991;
				#else
				float2 staticSwitch92 = uv_primitive310;
				#endif
				float2 UV313 = staticSwitch92;
				float2 temp_output_3_0_g6997 = UV313;
				float2 uv2_g6997 = temp_output_3_0_g6997;
				sampler2D tex2_g6997 = _BaseMap;
				float simpleNoise1_g6997 = SimpleNoise( temp_output_3_0_g6997*_ScaleOrRotate154 );
				simpleNoise1_g6997 = simpleNoise1_g6997*2 - 1;
				float noise2_g6997 = simpleNoise1_g6997;
				float4 localSampleSupportNoTileing_twoSample2_g6997 = SampleSupportNoTileing_twoSample( uv2_g6997 , tex2_g6997 , noise2_g6997 );
				float2 uv1_g6998 = UV313;
				sampler2D tex1_g6998 = _BaseMap;
				float scaleOrRotate1_g6998 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6998 = SampleSupportNoTileing_HexagonSample( uv1_g6998 , tex1_g6998 , scaleOrRotate1_g6998 );
				float2 uv1_g6996 = UV313;
				sampler2D tex1_g6996 = _BaseMap;
				float2 positionDSxy1_g6996 = IN.positionCS.xy;
				float4 localSampleSupportNoTileing_OneSample1_g6996 = SampleSupportNoTileing_OneSample( uv1_g6996 , tex1_g6996 , positionDSxy1_g6996 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch127 = tex2D( _BaseMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_twoSample2_g6997;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_HexagonSample1_g6998;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_OneSample1_g6996;
				#else
				float4 staticSwitch127 = float4( 0,0,0,0 );
				#endif
				float4 break198 = staticSwitch127;
				float alpha202 = break198.a;
				
				float2 temp_output_3_0_g6993 = UV313;
				float2 uv2_g6993 = temp_output_3_0_g6993;
				sampler2D tex2_g6993 = _NRAMap;
				float simpleNoise1_g6993 = SimpleNoise( temp_output_3_0_g6993*_ScaleOrRotate154 );
				simpleNoise1_g6993 = simpleNoise1_g6993*2 - 1;
				float noise2_g6993 = simpleNoise1_g6993;
				float4 localSampleSupportNoTileing_twoSample2_g6993 = SampleSupportNoTileing_twoSample( uv2_g6993 , tex2_g6993 , noise2_g6993 );
				float2 uv1_g6994 = UV313;
				sampler2D tex1_g6994 = _NRAMap;
				float scaleOrRotate1_g6994 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6994 = SampleSupportNoTileing_HexagonSample( uv1_g6994 , tex1_g6994 , scaleOrRotate1_g6994 );
				float2 uv1_g6992 = UV313;
				sampler2D tex1_g6992 = _NRAMap;
				float2 positionDSxy1_g6992 = IN.positionCS.xy;
				float4 localSampleSupportNoTileing_OneSample1_g6992 = SampleSupportNoTileing_OneSample( uv1_g6992 , tex1_g6992 , positionDSxy1_g6992 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch164 = tex2D( _NRAMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch164 = localSampleSupportNoTileing_twoSample2_g6993;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch164 = localSampleSupportNoTileing_HexagonSample1_g6994;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch164 = localSampleSupportNoTileing_OneSample1_g6992;
				#else
				float4 staticSwitch164 = float4( 0,0,0,0 );
				#endif
				float4 break205 = staticSwitch164;
				float2 appendResult206 = (float2(break205.r , break205.g));
				float2 normalMapRG1_g6995 = appendResult206;
				float4 localDecodeNormalRG1_g6995 = DecodeNormalRG( normalMapRG1_g6995 );
				float3 unpack4_g6995 = UnpackNormalScale( localDecodeNormalRG1_g6995, ( _BumpScale + 1.0 ) );
				unpack4_g6995.z = lerp( 1, unpack4_g6995.z, saturate(( _BumpScale + 1.0 )) );
				float3 normalTS208 = unpack4_g6995;
				float vertexToFrag326_g6964 = IN.ase_texcoord3.y;
				float vertexToFrag327_g6964 = IN.ase_texcoord3.z;
				float vertexToFrag328_g6964 = IN.ase_texcoord3.w;
				float3 appendResult134_g6964 = (float3(vertexToFrag326_g6964 , vertexToFrag327_g6964 , vertexToFrag328_g6964));
				float3 normalizeResult448_g6964 = normalize( appendResult134_g6964 );
				float3 TangentWS315_g6964 = normalizeResult448_g6964;
				float vertexToFrag329_g6964 = IN.ase_texcoord4.x;
				float vertexToFrag330_g6964 = IN.ase_texcoord4.y;
				float vertexToFrag331_g6964 = IN.ase_texcoord4.z;
				float3 appendResult144_g6964 = (float3(vertexToFrag329_g6964 , vertexToFrag330_g6964 , vertexToFrag331_g6964));
				float3 normalizeResult449_g6964 = normalize( appendResult144_g6964 );
				float3 BitangentWS316_g6964 = normalizeResult449_g6964;
				float vertexToFrag323_g6964 = IN.ase_texcoord4.w;
				float vertexToFrag324_g6964 = IN.ase_texcoord5.x;
				float vertexToFrag325_g6964 = IN.ase_texcoord5.y;
				float3 appendResult142_g6964 = (float3(vertexToFrag323_g6964 , vertexToFrag324_g6964 , vertexToFrag325_g6964));
				float3 normalizeResult459_g6964 = normalize( appendResult142_g6964 );
				float3 NormalWS388_g6964 = normalizeResult459_g6964;
				float3x3 TBN220 = float3x3(TangentWS315_g6964, BitangentWS316_g6964, NormalWS388_g6964);
				float3 normalizeResult320 = normalize( mul( normalTS208, TBN220 ) );
				float isFront317 = ase_vface;
				#ifdef EFFECT_BACKSIDE_NORMALS
				float3 staticSwitch58 = ( (float)(int)isFront317 != 0.0 ? normalizeResult320 : -normalizeResult320 );
				#else
				float3 staticSwitch58 = normalizeResult320;
				#endif
				float3 normalWS224 = staticSwitch58;
				

				float3 Color = float3(0.5, 0.5, 0.5);
				float Alpha = alpha202;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 WorldNormal = normalWS224;
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#if defined(_DBUFFER)
					ApplyDecalToBaseColor(IN.positionCS, Color);
				#endif

				#if defined(_ALPHAPREMULTIPLY_ON)
				Color *= Alpha;
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, FogFactor );
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				return half4( Color, Alpha );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_SRP_VERSION 140009


			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 RenderStateGroup2;
			float4 _BaseMap_ST;
			float4 _EmissionColor;
			float4 _HueVariationColor;
			float4 _SubsurfaceColor;
			float4 _SpecColor;
			float _ClearCoatSmoothness;
			float _ClearCoatMask;
			float _OcclusionStrength;
			float _Metallic;
			float _DetailOcclusionStrength2;
			float _HorizonOcclusion;
			float EmissionGI_GUI;
			float _SubsurfaceIndirect;
			float ExtraMixMap_Display;
			float _LogicalKeywordList;
			float _ScaleOrRotate;
			float _HoudiniFPS;
			float _BoundMin_Z;
			float _BoundMin_Y;
			float _BoundMin_X;
			float _DetailNormalScale2;
			float _DetailOcclusionStrength3;
			float _DetailNormalScale3;
			float _DetailOcclusionStrength0;
			float _DetailNormalScale0;
			float _DetailOcclusionStrength1;
			float _DetailNormalScale1;
			float _Parallax;
			float _AnimatorStrength;
			float _DisplayFrame;
			float _AutoPlay;
			float _IsPosTexHDR;
			float _FrameCount;
			float _BoundMax_X;
			float _BoundMax_Y;
			float _BoundMax_Z;
			float _PlaySpeed;
			float _BumpScale;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/BaseFunctionLibrary.hlsl"
			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/TextureFunctionLibrary.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment   _DETAIL _DETAIL_2MULTI _DETAIL_4MULTI
			#pragma shader_feature_local   EFFECT_HUE_VARIATION
			#pragma shader_feature_local   _CLEARCOAT
			#pragma shader_feature_local_fragment _OCCLUSION
			#pragma shader_feature_local _SHADER_PBR _SHADER_PLANT
			#pragma shader_feature_local_fragment _SAMPLE_COMMON _SAMPLE_NOISETILING _SAMPLE_HEXAGONTILING _SAMPLE_ONESAMPLEONTILING
			#pragma shader_feature_local_vertex _WINDQUALITY_NONE _WINDQUALITY_FASTEST _WINDQUALITY_FAST _WINDQUALITY_BETTER _WINDQUALITY_BEST _WINDQUALITY_PALM
			#pragma shader_feature_local  
			#pragma shader_feature_local_vertex   _HOUDINI_VAT_SOFT
			#pragma shader_feature_local_fragment _PARALLAXMAP_OFF _PARALLAXMAP


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;

				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _DetailMap3;
			sampler2D _DetailMap0;
			sampler2D _DetailMap1;
			sampler2D _DetailMap2;
			sampler2D _PositionVATMap;
			sampler2D _RotateVATMap;
			samplerCUBE _CustomReflectMap;
			sampler2D _ClearCoatMap;
			sampler2D _EmissionMixMap;
			sampler2D _ExtraMixMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;


			float3 TransformObjectToWorldNormal_Ref33_g6967( float3 normalOS )
			{
				return TransformObjectToWorldNormal(normalOS,false);
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 TransformWorldToTangentDir_Ref133_g6965( float3 directionWS, float3x3 TBN )
			{
				return TransformWorldToTangentDir(directionWS, TBN);
			}
			
			float2 IterativeParallaxLegacy1_g6991( float height, float2 UVs, float2 plane, float refp, float scale )
			{
				UVs += plane * scale * refp;
				UVs += (height - 1) * plane * scale;
				return UVs;
			}
			

			float3 _LightDirection;
			float3 _LightPosition;

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float localOffsetShadow412_g6964 = ( 0.0 );
				float localPosition1_g6976 = ( 0.0 );
				float localGetPositionTransformSpaceFromObject1_g6975 = ( 0.0 );
				float3 temp_output_14_0_g6968 = ( v.positionOS.xyz + float3( 0,0,0 ) );
				float3 positionOS1_g6975 = temp_output_14_0_g6968;
				Position position1_g6975 =(Position)0;
				GetPositionTransformSpaceFromObject_float( positionOS1_g6975 , position1_g6975 );
				Position position1_g6976 =(Position)position1_g6975;
				float3 OS1_g6976 = float3( 0,0,0 );
				float3 WS1_g6976 = float3( 0,0,0 );
				float3 VS1_g6976 = float3( 0,0,0 );
				float4 CS1_g6976 = float4( 0,0,0,0 );
				float4 NDC1_g6976 = float4( 0,0,0,0 );
				float3 SS1_g6976 = float3( 0,0,0 );
				float4 DS1_g6976 = float4( 0,0,0,0 );
				float3 LS1_g6976 = float3( 0,0,0 );
				float4 SC1_g6976 = float4( 0,0,0,0 );
				Position_float( position1_g6976 , OS1_g6976 , WS1_g6976 , VS1_g6976 , CS1_g6976 , NDC1_g6976 , SS1_g6976 , DS1_g6976 , LS1_g6976 , SC1_g6976 );
				float3 temp_output_345_7_g6964 = WS1_g6976;
				float3 positionWS412_g6964 = temp_output_345_7_g6964;
				float3 temp_output_31_0_g6967 = ( v.normalOS + float3( 0,0,0 ) );
				float3 normalOS33_g6967 = temp_output_31_0_g6967;
				float3 localTransformObjectToWorldNormal_Ref33_g6967 = TransformObjectToWorldNormal_Ref33_g6967( normalOS33_g6967 );
				float3 normalizeResult140_g6967 = ASESafeNormalize( localTransformObjectToWorldNormal_Ref33_g6967 );
				float3 temp_output_515_34_g6964 = normalizeResult140_g6967;
				float3 normalWS412_g6964 = temp_output_515_34_g6964;
				float4 positionCS412_g6964 = float4( 0,0,0,0 );
				{
				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
				float3 lightDirectionWS = normalize(_LightPosition - positionWS412_g6964);
				#else
				float3 lightDirectionWS = _LightDirection;
				#endif
				positionCS412_g6964 = TransformWorldToHClip(ApplyShadowBias(positionWS412_g6964, normalWS412_g6964, lightDirectionWS));
				#if UNITY_REVERSED_Z
				positionCS412_g6964.z = min(positionCS412_g6964.z, UNITY_NEAR_CLIP_VALUE);
				#else
				positionCS412_g6964.z = max(positionCS412_g6964.z, UNITY_NEAR_CLIP_VALUE);
				#endif
				}
				
				float2 break242 = ( ( v.ase_texcoord.xy * _BaseMap_ST.xy ) + _BaseMap_ST.zw );
				float vertexToFrag237 = break242.x;
				o.ase_texcoord.x = vertexToFrag237;
				float vertexToFrag236 = break242.y;
				o.ase_texcoord.y = vertexToFrag236;
				float3 vertexPositionWS386_g6964 = temp_output_345_7_g6964;
				float3 normalizeResult129_g6964 = ASESafeNormalize( ( _WorldSpaceCameraPos - vertexPositionWS386_g6964 ) );
				float3 temp_output_43_0_g6965 = normalizeResult129_g6964;
				float3 directionWS133_g6965 = temp_output_43_0_g6965;
				float3 temp_output_43_0_g6966 = ( v.ase_tangent.xyz + float3( 0,0,0 ) );
				float3 objToWorldDir42_g6966 = mul( GetObjectToWorldMatrix(), float4( temp_output_43_0_g6966, 0 ) ).xyz;
				float3 normalizeResult128_g6966 = ASESafeNormalize( objToWorldDir42_g6966 );
				float3 VertexTangentlWS474_g6964 = normalizeResult128_g6966;
				float3 VertexNormalWS314_g6964 = temp_output_515_34_g6964;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 normalizeResult473_g6964 = ASESafeNormalize( ( cross( VertexNormalWS314_g6964 , VertexTangentlWS474_g6964 ) * ase_vertexTangentSign ) );
				float3 VertexBitangentWS476_g6964 = normalizeResult473_g6964;
				float3x3 temp_output_103_0_g6965 = float3x3(VertexTangentlWS474_g6964, VertexBitangentWS476_g6964, VertexNormalWS314_g6964);
				float3x3 TBN133_g6965 = temp_output_103_0_g6965;
				float3 localTransformWorldToTangentDir_Ref133_g6965 = TransformWorldToTangentDir_Ref133_g6965( directionWS133_g6965 , TBN133_g6965 );
				float3 normalizeResult132_g6965 = ASESafeNormalize( localTransformWorldToTangentDir_Ref133_g6965 );
				float3 break336_g6964 = normalizeResult132_g6965;
				float vertexToFrag264_g6964 = break336_g6964.x;
				o.ase_texcoord.z = vertexToFrag264_g6964;
				float vertexToFrag337_g6964 = break336_g6964.y;
				o.ase_texcoord.w = vertexToFrag337_g6964;
				float vertexToFrag338_g6964 = break336_g6964.z;
				o.ase_texcoord1.x = vertexToFrag338_g6964;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.yzw = 0;

				o.positionCS = positionCS412_g6964;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float vertexToFrag237 = IN.ase_texcoord.x;
				float vertexToFrag236 = IN.ase_texcoord.y;
				float2 appendResult238 = (float2(vertexToFrag237 , vertexToFrag236));
				float2 uv_primitive310 = appendResult238;
				float4 tex2DNode94 = tex2D( _HeightMap, uv_primitive310 );
				float2 temp_output_3_0_g2109 = uv_primitive310;
				float2 uv2_g2109 = temp_output_3_0_g2109;
				sampler2D tex2_g2109 = _HeightMap;
				float _ScaleOrRotate154 = _ScaleOrRotate;
				float simpleNoise1_g2109 = SimpleNoise( temp_output_3_0_g2109*_ScaleOrRotate154 );
				simpleNoise1_g2109 = simpleNoise1_g2109*2 - 1;
				float noise2_g2109 = simpleNoise1_g2109;
				float4 localSampleSupportNoTileing_twoSample2_g2109 = SampleSupportNoTileing_twoSample( uv2_g2109 , tex2_g2109 , noise2_g2109 );
				float2 uv1_g2108 = uv_primitive310;
				sampler2D tex1_g2108 = _HeightMap;
				float scaleOrRotate1_g2108 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g2108 = SampleSupportNoTileing_HexagonSample( uv1_g2108 , tex1_g2108 , scaleOrRotate1_g2108 );
				float2 uv1_g2110 = uv_primitive310;
				sampler2D tex1_g2110 = _HeightMap;
				float2 positionDSxy1_g2110 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g2110 = SampleSupportNoTileing_OneSample( uv1_g2110 , tex1_g2110 , positionDSxy1_g2110 );
				#if defined(_SAMPLE_COMMON)
				float staticSwitch332 = ( ( tex2DNode94.r + tex2DNode94.g + tex2DNode94.b + tex2DNode94.a ) / 4.0 );
				#elif defined(_SAMPLE_NOISETILING)
				float staticSwitch332 = (localSampleSupportNoTileing_twoSample2_g2109).x;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_HexagonSample1_g2108).x;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_OneSample1_g2110).x;
				#else
				float staticSwitch332 = 0.0;
				#endif
				float height308 = staticSwitch332;
				float height1_g6991 = height308;
				float2 UVs1_g6991 = uv_primitive310;
				float vertexToFrag264_g6964 = IN.ase_texcoord.z;
				float vertexToFrag337_g6964 = IN.ase_texcoord.w;
				float vertexToFrag338_g6964 = IN.ase_texcoord1.x;
				float3 appendResult340_g6964 = (float3(vertexToFrag264_g6964 , vertexToFrag337_g6964 , vertexToFrag338_g6964));
				float3 normalizeResult451_g6964 = normalize( appendResult340_g6964 );
				float3 viewDirTS311 = normalizeResult451_g6964;
				float3 break6_g6991 = viewDirTS311;
				float2 appendResult5_g6991 = (float2(break6_g6991.x , break6_g6991.y));
				float2 plane1_g6991 = ( appendResult5_g6991 / break6_g6991.z );
				float refp1_g6991 = 0.5;
				float scale1_g6991 = _Parallax;
				float2 localIterativeParallaxLegacy1_g6991 = IterativeParallaxLegacy1_g6991( height1_g6991 , UVs1_g6991 , plane1_g6991 , refp1_g6991 , scale1_g6991 );
				#if defined(_PARALLAXMAP_OFF)
				float2 staticSwitch92 = uv_primitive310;
				#elif defined(_PARALLAXMAP)
				float2 staticSwitch92 = localIterativeParallaxLegacy1_g6991;
				#else
				float2 staticSwitch92 = uv_primitive310;
				#endif
				float2 UV313 = staticSwitch92;
				float2 temp_output_3_0_g6997 = UV313;
				float2 uv2_g6997 = temp_output_3_0_g6997;
				sampler2D tex2_g6997 = _BaseMap;
				float simpleNoise1_g6997 = SimpleNoise( temp_output_3_0_g6997*_ScaleOrRotate154 );
				simpleNoise1_g6997 = simpleNoise1_g6997*2 - 1;
				float noise2_g6997 = simpleNoise1_g6997;
				float4 localSampleSupportNoTileing_twoSample2_g6997 = SampleSupportNoTileing_twoSample( uv2_g6997 , tex2_g6997 , noise2_g6997 );
				float2 uv1_g6998 = UV313;
				sampler2D tex1_g6998 = _BaseMap;
				float scaleOrRotate1_g6998 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6998 = SampleSupportNoTileing_HexagonSample( uv1_g6998 , tex1_g6998 , scaleOrRotate1_g6998 );
				float2 uv1_g6996 = UV313;
				sampler2D tex1_g6996 = _BaseMap;
				float2 positionDSxy1_g6996 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g6996 = SampleSupportNoTileing_OneSample( uv1_g6996 , tex1_g6996 , positionDSxy1_g6996 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch127 = tex2D( _BaseMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_twoSample2_g6997;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_HexagonSample1_g6998;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_OneSample1_g6996;
				#else
				float4 staticSwitch127 = float4( 0,0,0,0 );
				#endif
				float4 break198 = staticSwitch127;
				float alpha202 = break198.a;
				

				float Alpha = alpha202;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask R
			AlphaToMask Off

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_SRP_VERSION 140009


			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 RenderStateGroup2;
			float4 _BaseMap_ST;
			float4 _EmissionColor;
			float4 _HueVariationColor;
			float4 _SubsurfaceColor;
			float4 _SpecColor;
			float _ClearCoatSmoothness;
			float _ClearCoatMask;
			float _OcclusionStrength;
			float _Metallic;
			float _DetailOcclusionStrength2;
			float _HorizonOcclusion;
			float EmissionGI_GUI;
			float _SubsurfaceIndirect;
			float ExtraMixMap_Display;
			float _LogicalKeywordList;
			float _ScaleOrRotate;
			float _HoudiniFPS;
			float _BoundMin_Z;
			float _BoundMin_Y;
			float _BoundMin_X;
			float _DetailNormalScale2;
			float _DetailOcclusionStrength3;
			float _DetailNormalScale3;
			float _DetailOcclusionStrength0;
			float _DetailNormalScale0;
			float _DetailOcclusionStrength1;
			float _DetailNormalScale1;
			float _Parallax;
			float _AnimatorStrength;
			float _DisplayFrame;
			float _AutoPlay;
			float _IsPosTexHDR;
			float _FrameCount;
			float _BoundMax_X;
			float _BoundMax_Y;
			float _BoundMax_Z;
			float _PlaySpeed;
			float _BumpScale;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			

			#pragma vertex vert
			#pragma fragment frag

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/BaseFunctionLibrary.hlsl"
			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/TextureFunctionLibrary.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment   _DETAIL _DETAIL_2MULTI _DETAIL_4MULTI
			#pragma shader_feature_local   EFFECT_HUE_VARIATION
			#pragma shader_feature_local   _CLEARCOAT
			#pragma shader_feature_local_fragment _OCCLUSION
			#pragma shader_feature_local _SHADER_PBR _SHADER_PLANT
			#pragma shader_feature_local_fragment _SAMPLE_COMMON _SAMPLE_NOISETILING _SAMPLE_HEXAGONTILING _SAMPLE_ONESAMPLEONTILING
			#pragma shader_feature_local_vertex _WINDQUALITY_NONE _WINDQUALITY_FASTEST _WINDQUALITY_FAST _WINDQUALITY_BETTER _WINDQUALITY_BEST _WINDQUALITY_PALM
			#pragma shader_feature_local  
			#pragma shader_feature_local_vertex   _HOUDINI_VAT_SOFT
			#pragma shader_feature_local_fragment _PARALLAXMAP_OFF _PARALLAXMAP


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _DetailMap3;
			sampler2D _DetailMap0;
			sampler2D _DetailMap1;
			sampler2D _DetailMap2;
			sampler2D _PositionVATMap;
			sampler2D _RotateVATMap;
			samplerCUBE _CustomReflectMap;
			sampler2D _ClearCoatMap;
			sampler2D _EmissionMixMap;
			sampler2D _ExtraMixMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;


			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 TransformObjectToWorldNormal_Ref33_g6967( float3 normalOS )
			{
				return TransformObjectToWorldNormal(normalOS,false);
			}
			
			float3 TransformWorldToTangentDir_Ref133_g6965( float3 directionWS, float3x3 TBN )
			{
				return TransformWorldToTangentDir(directionWS, TBN);
			}
			
			float2 IterativeParallaxLegacy1_g6991( float height, float2 UVs, float2 plane, float refp, float scale )
			{
				UVs += plane * scale * refp;
				UVs += (height - 1) * plane * scale;
				return UVs;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float localPosition1_g6976 = ( 0.0 );
				float localGetPositionTransformSpaceFromObject1_g6975 = ( 0.0 );
				float3 temp_output_14_0_g6968 = ( v.positionOS.xyz + float3( 0,0,0 ) );
				float3 positionOS1_g6975 = temp_output_14_0_g6968;
				Position position1_g6975 =(Position)0;
				GetPositionTransformSpaceFromObject_float( positionOS1_g6975 , position1_g6975 );
				Position position1_g6976 =(Position)position1_g6975;
				float3 OS1_g6976 = float3( 0,0,0 );
				float3 WS1_g6976 = float3( 0,0,0 );
				float3 VS1_g6976 = float3( 0,0,0 );
				float4 CS1_g6976 = float4( 0,0,0,0 );
				float4 NDC1_g6976 = float4( 0,0,0,0 );
				float3 SS1_g6976 = float3( 0,0,0 );
				float4 DS1_g6976 = float4( 0,0,0,0 );
				float3 LS1_g6976 = float3( 0,0,0 );
				float4 SC1_g6976 = float4( 0,0,0,0 );
				Position_float( position1_g6976 , OS1_g6976 , WS1_g6976 , VS1_g6976 , CS1_g6976 , NDC1_g6976 , SS1_g6976 , DS1_g6976 , LS1_g6976 , SC1_g6976 );
				float4 vertexPositionCS382_g6964 = CS1_g6976;
				float4 temp_output_478_313 = vertexPositionCS382_g6964;
				
				float2 break242 = ( ( v.ase_texcoord.xy * _BaseMap_ST.xy ) + _BaseMap_ST.zw );
				float vertexToFrag237 = break242.x;
				o.ase_texcoord.x = vertexToFrag237;
				float vertexToFrag236 = break242.y;
				o.ase_texcoord.y = vertexToFrag236;
				float3 temp_output_345_7_g6964 = WS1_g6976;
				float3 vertexPositionWS386_g6964 = temp_output_345_7_g6964;
				float3 normalizeResult129_g6964 = ASESafeNormalize( ( _WorldSpaceCameraPos - vertexPositionWS386_g6964 ) );
				float3 temp_output_43_0_g6965 = normalizeResult129_g6964;
				float3 directionWS133_g6965 = temp_output_43_0_g6965;
				float3 temp_output_43_0_g6966 = ( v.ase_tangent.xyz + float3( 0,0,0 ) );
				float3 objToWorldDir42_g6966 = mul( GetObjectToWorldMatrix(), float4( temp_output_43_0_g6966, 0 ) ).xyz;
				float3 normalizeResult128_g6966 = ASESafeNormalize( objToWorldDir42_g6966 );
				float3 VertexTangentlWS474_g6964 = normalizeResult128_g6966;
				float3 temp_output_31_0_g6967 = ( v.normalOS + float3( 0,0,0 ) );
				float3 normalOS33_g6967 = temp_output_31_0_g6967;
				float3 localTransformObjectToWorldNormal_Ref33_g6967 = TransformObjectToWorldNormal_Ref33_g6967( normalOS33_g6967 );
				float3 normalizeResult140_g6967 = ASESafeNormalize( localTransformObjectToWorldNormal_Ref33_g6967 );
				float3 temp_output_515_34_g6964 = normalizeResult140_g6967;
				float3 VertexNormalWS314_g6964 = temp_output_515_34_g6964;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 normalizeResult473_g6964 = ASESafeNormalize( ( cross( VertexNormalWS314_g6964 , VertexTangentlWS474_g6964 ) * ase_vertexTangentSign ) );
				float3 VertexBitangentWS476_g6964 = normalizeResult473_g6964;
				float3x3 temp_output_103_0_g6965 = float3x3(VertexTangentlWS474_g6964, VertexBitangentWS476_g6964, VertexNormalWS314_g6964);
				float3x3 TBN133_g6965 = temp_output_103_0_g6965;
				float3 localTransformWorldToTangentDir_Ref133_g6965 = TransformWorldToTangentDir_Ref133_g6965( directionWS133_g6965 , TBN133_g6965 );
				float3 normalizeResult132_g6965 = ASESafeNormalize( localTransformWorldToTangentDir_Ref133_g6965 );
				float3 break336_g6964 = normalizeResult132_g6965;
				float vertexToFrag264_g6964 = break336_g6964.x;
				o.ase_texcoord.z = vertexToFrag264_g6964;
				float vertexToFrag337_g6964 = break336_g6964.y;
				o.ase_texcoord.w = vertexToFrag337_g6964;
				float vertexToFrag338_g6964 = break336_g6964.z;
				o.ase_texcoord1.x = vertexToFrag338_g6964;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.yzw = 0;

				o.positionCS = temp_output_478_313;


				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float vertexToFrag237 = IN.ase_texcoord.x;
				float vertexToFrag236 = IN.ase_texcoord.y;
				float2 appendResult238 = (float2(vertexToFrag237 , vertexToFrag236));
				float2 uv_primitive310 = appendResult238;
				float4 tex2DNode94 = tex2D( _HeightMap, uv_primitive310 );
				float2 temp_output_3_0_g2109 = uv_primitive310;
				float2 uv2_g2109 = temp_output_3_0_g2109;
				sampler2D tex2_g2109 = _HeightMap;
				float _ScaleOrRotate154 = _ScaleOrRotate;
				float simpleNoise1_g2109 = SimpleNoise( temp_output_3_0_g2109*_ScaleOrRotate154 );
				simpleNoise1_g2109 = simpleNoise1_g2109*2 - 1;
				float noise2_g2109 = simpleNoise1_g2109;
				float4 localSampleSupportNoTileing_twoSample2_g2109 = SampleSupportNoTileing_twoSample( uv2_g2109 , tex2_g2109 , noise2_g2109 );
				float2 uv1_g2108 = uv_primitive310;
				sampler2D tex1_g2108 = _HeightMap;
				float scaleOrRotate1_g2108 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g2108 = SampleSupportNoTileing_HexagonSample( uv1_g2108 , tex1_g2108 , scaleOrRotate1_g2108 );
				float2 uv1_g2110 = uv_primitive310;
				sampler2D tex1_g2110 = _HeightMap;
				float2 positionDSxy1_g2110 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g2110 = SampleSupportNoTileing_OneSample( uv1_g2110 , tex1_g2110 , positionDSxy1_g2110 );
				#if defined(_SAMPLE_COMMON)
				float staticSwitch332 = ( ( tex2DNode94.r + tex2DNode94.g + tex2DNode94.b + tex2DNode94.a ) / 4.0 );
				#elif defined(_SAMPLE_NOISETILING)
				float staticSwitch332 = (localSampleSupportNoTileing_twoSample2_g2109).x;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_HexagonSample1_g2108).x;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_OneSample1_g2110).x;
				#else
				float staticSwitch332 = 0.0;
				#endif
				float height308 = staticSwitch332;
				float height1_g6991 = height308;
				float2 UVs1_g6991 = uv_primitive310;
				float vertexToFrag264_g6964 = IN.ase_texcoord.z;
				float vertexToFrag337_g6964 = IN.ase_texcoord.w;
				float vertexToFrag338_g6964 = IN.ase_texcoord1.x;
				float3 appendResult340_g6964 = (float3(vertexToFrag264_g6964 , vertexToFrag337_g6964 , vertexToFrag338_g6964));
				float3 normalizeResult451_g6964 = normalize( appendResult340_g6964 );
				float3 viewDirTS311 = normalizeResult451_g6964;
				float3 break6_g6991 = viewDirTS311;
				float2 appendResult5_g6991 = (float2(break6_g6991.x , break6_g6991.y));
				float2 plane1_g6991 = ( appendResult5_g6991 / break6_g6991.z );
				float refp1_g6991 = 0.5;
				float scale1_g6991 = _Parallax;
				float2 localIterativeParallaxLegacy1_g6991 = IterativeParallaxLegacy1_g6991( height1_g6991 , UVs1_g6991 , plane1_g6991 , refp1_g6991 , scale1_g6991 );
				#if defined(_PARALLAXMAP_OFF)
				float2 staticSwitch92 = uv_primitive310;
				#elif defined(_PARALLAXMAP)
				float2 staticSwitch92 = localIterativeParallaxLegacy1_g6991;
				#else
				float2 staticSwitch92 = uv_primitive310;
				#endif
				float2 UV313 = staticSwitch92;
				float2 temp_output_3_0_g6997 = UV313;
				float2 uv2_g6997 = temp_output_3_0_g6997;
				sampler2D tex2_g6997 = _BaseMap;
				float simpleNoise1_g6997 = SimpleNoise( temp_output_3_0_g6997*_ScaleOrRotate154 );
				simpleNoise1_g6997 = simpleNoise1_g6997*2 - 1;
				float noise2_g6997 = simpleNoise1_g6997;
				float4 localSampleSupportNoTileing_twoSample2_g6997 = SampleSupportNoTileing_twoSample( uv2_g6997 , tex2_g6997 , noise2_g6997 );
				float2 uv1_g6998 = UV313;
				sampler2D tex1_g6998 = _BaseMap;
				float scaleOrRotate1_g6998 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6998 = SampleSupportNoTileing_HexagonSample( uv1_g6998 , tex1_g6998 , scaleOrRotate1_g6998 );
				float2 uv1_g6996 = UV313;
				sampler2D tex1_g6996 = _BaseMap;
				float2 positionDSxy1_g6996 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g6996 = SampleSupportNoTileing_OneSample( uv1_g6996 , tex1_g6996 , positionDSxy1_g6996 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch127 = tex2D( _BaseMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_twoSample2_g6997;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_HexagonSample1_g6998;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_OneSample1_g6996;
				#else
				float4 staticSwitch127 = float4( 0,0,0,0 );
				#endif
				float4 break198 = staticSwitch127;
				float alpha202 = break198.a;
				

				float Alpha = alpha202;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif
				return IN.positionCS.z;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			#define ASE_SRP_VERSION 140009


			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 RenderStateGroup2;
			float4 _BaseMap_ST;
			float4 _EmissionColor;
			float4 _HueVariationColor;
			float4 _SubsurfaceColor;
			float4 _SpecColor;
			float _ClearCoatSmoothness;
			float _ClearCoatMask;
			float _OcclusionStrength;
			float _Metallic;
			float _DetailOcclusionStrength2;
			float _HorizonOcclusion;
			float EmissionGI_GUI;
			float _SubsurfaceIndirect;
			float ExtraMixMap_Display;
			float _LogicalKeywordList;
			float _ScaleOrRotate;
			float _HoudiniFPS;
			float _BoundMin_Z;
			float _BoundMin_Y;
			float _BoundMin_X;
			float _DetailNormalScale2;
			float _DetailOcclusionStrength3;
			float _DetailNormalScale3;
			float _DetailOcclusionStrength0;
			float _DetailNormalScale0;
			float _DetailOcclusionStrength1;
			float _DetailNormalScale1;
			float _Parallax;
			float _AnimatorStrength;
			float _DisplayFrame;
			float _AutoPlay;
			float _IsPosTexHDR;
			float _FrameCount;
			float _BoundMax_X;
			float _BoundMax_Y;
			float _BoundMax_Z;
			float _PlaySpeed;
			float _BumpScale;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			

			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/BaseFunctionLibrary.hlsl"
			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/TextureFunctionLibrary.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment   _DETAIL _DETAIL_2MULTI _DETAIL_4MULTI
			#pragma shader_feature_local   EFFECT_HUE_VARIATION
			#pragma shader_feature_local   _CLEARCOAT
			#pragma shader_feature_local_fragment _OCCLUSION
			#pragma shader_feature_local _SHADER_PBR _SHADER_PLANT
			#pragma shader_feature_local_fragment _SAMPLE_COMMON _SAMPLE_NOISETILING _SAMPLE_HEXAGONTILING _SAMPLE_ONESAMPLEONTILING
			#pragma shader_feature_local_vertex _WINDQUALITY_NONE _WINDQUALITY_FASTEST _WINDQUALITY_FAST _WINDQUALITY_BETTER _WINDQUALITY_BEST _WINDQUALITY_PALM
			#pragma shader_feature_local  
			#pragma shader_feature_local_vertex   _HOUDINI_VAT_SOFT
			#pragma shader_feature_local_fragment _PARALLAXMAP_OFF _PARALLAXMAP


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _DetailMap3;
			sampler2D _DetailMap0;
			sampler2D _DetailMap1;
			sampler2D _DetailMap2;
			sampler2D _PositionVATMap;
			sampler2D _RotateVATMap;
			samplerCUBE _CustomReflectMap;
			sampler2D _ClearCoatMap;
			sampler2D _EmissionMixMap;
			sampler2D _ExtraMixMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;


			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 TransformObjectToWorldNormal_Ref33_g6967( float3 normalOS )
			{
				return TransformObjectToWorldNormal(normalOS,false);
			}
			
			float3 TransformWorldToTangentDir_Ref133_g6965( float3 directionWS, float3x3 TBN )
			{
				return TransformWorldToTangentDir(directionWS, TBN);
			}
			
			float2 IterativeParallaxLegacy1_g6991( float height, float2 UVs, float2 plane, float refp, float scale )
			{
				UVs += plane * scale * refp;
				UVs += (height - 1) * plane * scale;
				return UVs;
			}
			

			int _ObjectId;
			int _PassValue;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float localPosition1_g6976 = ( 0.0 );
				float localGetPositionTransformSpaceFromObject1_g6975 = ( 0.0 );
				float3 temp_output_14_0_g6968 = ( v.positionOS.xyz + float3( 0,0,0 ) );
				float3 positionOS1_g6975 = temp_output_14_0_g6968;
				Position position1_g6975 =(Position)0;
				GetPositionTransformSpaceFromObject_float( positionOS1_g6975 , position1_g6975 );
				Position position1_g6976 =(Position)position1_g6975;
				float3 OS1_g6976 = float3( 0,0,0 );
				float3 WS1_g6976 = float3( 0,0,0 );
				float3 VS1_g6976 = float3( 0,0,0 );
				float4 CS1_g6976 = float4( 0,0,0,0 );
				float4 NDC1_g6976 = float4( 0,0,0,0 );
				float3 SS1_g6976 = float3( 0,0,0 );
				float4 DS1_g6976 = float4( 0,0,0,0 );
				float3 LS1_g6976 = float3( 0,0,0 );
				float4 SC1_g6976 = float4( 0,0,0,0 );
				Position_float( position1_g6976 , OS1_g6976 , WS1_g6976 , VS1_g6976 , CS1_g6976 , NDC1_g6976 , SS1_g6976 , DS1_g6976 , LS1_g6976 , SC1_g6976 );
				float4 vertexPositionCS382_g6964 = CS1_g6976;
				float4 temp_output_478_313 = vertexPositionCS382_g6964;
				
				float2 break242 = ( ( v.ase_texcoord.xy * _BaseMap_ST.xy ) + _BaseMap_ST.zw );
				float vertexToFrag237 = break242.x;
				o.ase_texcoord.x = vertexToFrag237;
				float vertexToFrag236 = break242.y;
				o.ase_texcoord.y = vertexToFrag236;
				float3 temp_output_345_7_g6964 = WS1_g6976;
				float3 vertexPositionWS386_g6964 = temp_output_345_7_g6964;
				float3 normalizeResult129_g6964 = ASESafeNormalize( ( _WorldSpaceCameraPos - vertexPositionWS386_g6964 ) );
				float3 temp_output_43_0_g6965 = normalizeResult129_g6964;
				float3 directionWS133_g6965 = temp_output_43_0_g6965;
				float3 temp_output_43_0_g6966 = ( v.ase_tangent.xyz + float3( 0,0,0 ) );
				float3 objToWorldDir42_g6966 = mul( GetObjectToWorldMatrix(), float4( temp_output_43_0_g6966, 0 ) ).xyz;
				float3 normalizeResult128_g6966 = ASESafeNormalize( objToWorldDir42_g6966 );
				float3 VertexTangentlWS474_g6964 = normalizeResult128_g6966;
				float3 temp_output_31_0_g6967 = ( v.normalOS + float3( 0,0,0 ) );
				float3 normalOS33_g6967 = temp_output_31_0_g6967;
				float3 localTransformObjectToWorldNormal_Ref33_g6967 = TransformObjectToWorldNormal_Ref33_g6967( normalOS33_g6967 );
				float3 normalizeResult140_g6967 = ASESafeNormalize( localTransformObjectToWorldNormal_Ref33_g6967 );
				float3 temp_output_515_34_g6964 = normalizeResult140_g6967;
				float3 VertexNormalWS314_g6964 = temp_output_515_34_g6964;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 normalizeResult473_g6964 = ASESafeNormalize( ( cross( VertexNormalWS314_g6964 , VertexTangentlWS474_g6964 ) * ase_vertexTangentSign ) );
				float3 VertexBitangentWS476_g6964 = normalizeResult473_g6964;
				float3x3 temp_output_103_0_g6965 = float3x3(VertexTangentlWS474_g6964, VertexBitangentWS476_g6964, VertexNormalWS314_g6964);
				float3x3 TBN133_g6965 = temp_output_103_0_g6965;
				float3 localTransformWorldToTangentDir_Ref133_g6965 = TransformWorldToTangentDir_Ref133_g6965( directionWS133_g6965 , TBN133_g6965 );
				float3 normalizeResult132_g6965 = ASESafeNormalize( localTransformWorldToTangentDir_Ref133_g6965 );
				float3 break336_g6964 = normalizeResult132_g6965;
				float vertexToFrag264_g6964 = break336_g6964.x;
				o.ase_texcoord.z = vertexToFrag264_g6964;
				float vertexToFrag337_g6964 = break336_g6964.y;
				o.ase_texcoord.w = vertexToFrag337_g6964;
				float vertexToFrag338_g6964 = break336_g6964.z;
				o.ase_texcoord1.x = vertexToFrag338_g6964;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.yzw = 0;

				o.positionCS = temp_output_478_313;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float vertexToFrag237 = IN.ase_texcoord.x;
				float vertexToFrag236 = IN.ase_texcoord.y;
				float2 appendResult238 = (float2(vertexToFrag237 , vertexToFrag236));
				float2 uv_primitive310 = appendResult238;
				float4 tex2DNode94 = tex2D( _HeightMap, uv_primitive310 );
				float2 temp_output_3_0_g2109 = uv_primitive310;
				float2 uv2_g2109 = temp_output_3_0_g2109;
				sampler2D tex2_g2109 = _HeightMap;
				float _ScaleOrRotate154 = _ScaleOrRotate;
				float simpleNoise1_g2109 = SimpleNoise( temp_output_3_0_g2109*_ScaleOrRotate154 );
				simpleNoise1_g2109 = simpleNoise1_g2109*2 - 1;
				float noise2_g2109 = simpleNoise1_g2109;
				float4 localSampleSupportNoTileing_twoSample2_g2109 = SampleSupportNoTileing_twoSample( uv2_g2109 , tex2_g2109 , noise2_g2109 );
				float2 uv1_g2108 = uv_primitive310;
				sampler2D tex1_g2108 = _HeightMap;
				float scaleOrRotate1_g2108 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g2108 = SampleSupportNoTileing_HexagonSample( uv1_g2108 , tex1_g2108 , scaleOrRotate1_g2108 );
				float2 uv1_g2110 = uv_primitive310;
				sampler2D tex1_g2110 = _HeightMap;
				float2 positionDSxy1_g2110 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g2110 = SampleSupportNoTileing_OneSample( uv1_g2110 , tex1_g2110 , positionDSxy1_g2110 );
				#if defined(_SAMPLE_COMMON)
				float staticSwitch332 = ( ( tex2DNode94.r + tex2DNode94.g + tex2DNode94.b + tex2DNode94.a ) / 4.0 );
				#elif defined(_SAMPLE_NOISETILING)
				float staticSwitch332 = (localSampleSupportNoTileing_twoSample2_g2109).x;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_HexagonSample1_g2108).x;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_OneSample1_g2110).x;
				#else
				float staticSwitch332 = 0.0;
				#endif
				float height308 = staticSwitch332;
				float height1_g6991 = height308;
				float2 UVs1_g6991 = uv_primitive310;
				float vertexToFrag264_g6964 = IN.ase_texcoord.z;
				float vertexToFrag337_g6964 = IN.ase_texcoord.w;
				float vertexToFrag338_g6964 = IN.ase_texcoord1.x;
				float3 appendResult340_g6964 = (float3(vertexToFrag264_g6964 , vertexToFrag337_g6964 , vertexToFrag338_g6964));
				float3 normalizeResult451_g6964 = normalize( appendResult340_g6964 );
				float3 viewDirTS311 = normalizeResult451_g6964;
				float3 break6_g6991 = viewDirTS311;
				float2 appendResult5_g6991 = (float2(break6_g6991.x , break6_g6991.y));
				float2 plane1_g6991 = ( appendResult5_g6991 / break6_g6991.z );
				float refp1_g6991 = 0.5;
				float scale1_g6991 = _Parallax;
				float2 localIterativeParallaxLegacy1_g6991 = IterativeParallaxLegacy1_g6991( height1_g6991 , UVs1_g6991 , plane1_g6991 , refp1_g6991 , scale1_g6991 );
				#if defined(_PARALLAXMAP_OFF)
				float2 staticSwitch92 = uv_primitive310;
				#elif defined(_PARALLAXMAP)
				float2 staticSwitch92 = localIterativeParallaxLegacy1_g6991;
				#else
				float2 staticSwitch92 = uv_primitive310;
				#endif
				float2 UV313 = staticSwitch92;
				float2 temp_output_3_0_g6997 = UV313;
				float2 uv2_g6997 = temp_output_3_0_g6997;
				sampler2D tex2_g6997 = _BaseMap;
				float simpleNoise1_g6997 = SimpleNoise( temp_output_3_0_g6997*_ScaleOrRotate154 );
				simpleNoise1_g6997 = simpleNoise1_g6997*2 - 1;
				float noise2_g6997 = simpleNoise1_g6997;
				float4 localSampleSupportNoTileing_twoSample2_g6997 = SampleSupportNoTileing_twoSample( uv2_g6997 , tex2_g6997 , noise2_g6997 );
				float2 uv1_g6998 = UV313;
				sampler2D tex1_g6998 = _BaseMap;
				float scaleOrRotate1_g6998 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6998 = SampleSupportNoTileing_HexagonSample( uv1_g6998 , tex1_g6998 , scaleOrRotate1_g6998 );
				float2 uv1_g6996 = UV313;
				sampler2D tex1_g6996 = _BaseMap;
				float2 positionDSxy1_g6996 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g6996 = SampleSupportNoTileing_OneSample( uv1_g6996 , tex1_g6996 , positionDSxy1_g6996 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch127 = tex2D( _BaseMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_twoSample2_g6997;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_HexagonSample1_g6998;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_OneSample1_g6996;
				#else
				float4 staticSwitch127 = float4( 0,0,0,0 );
				#endif
				float4 break198 = staticSwitch127;
				float alpha202 = break198.a;
				

				surfaceDescription.Alpha = alpha202;
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				return outColor;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			#define ASE_SRP_VERSION 140009


			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 RenderStateGroup2;
			float4 _BaseMap_ST;
			float4 _EmissionColor;
			float4 _HueVariationColor;
			float4 _SubsurfaceColor;
			float4 _SpecColor;
			float _ClearCoatSmoothness;
			float _ClearCoatMask;
			float _OcclusionStrength;
			float _Metallic;
			float _DetailOcclusionStrength2;
			float _HorizonOcclusion;
			float EmissionGI_GUI;
			float _SubsurfaceIndirect;
			float ExtraMixMap_Display;
			float _LogicalKeywordList;
			float _ScaleOrRotate;
			float _HoudiniFPS;
			float _BoundMin_Z;
			float _BoundMin_Y;
			float _BoundMin_X;
			float _DetailNormalScale2;
			float _DetailOcclusionStrength3;
			float _DetailNormalScale3;
			float _DetailOcclusionStrength0;
			float _DetailNormalScale0;
			float _DetailOcclusionStrength1;
			float _DetailNormalScale1;
			float _Parallax;
			float _AnimatorStrength;
			float _DisplayFrame;
			float _AutoPlay;
			float _IsPosTexHDR;
			float _FrameCount;
			float _BoundMax_X;
			float _BoundMax_Y;
			float _BoundMax_Z;
			float _PlaySpeed;
			float _BumpScale;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			

			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT

			#define SHADERPASS SHADERPASS_DEPTHONLY

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/BaseFunctionLibrary.hlsl"
			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/TextureFunctionLibrary.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment   _DETAIL _DETAIL_2MULTI _DETAIL_4MULTI
			#pragma shader_feature_local   EFFECT_HUE_VARIATION
			#pragma shader_feature_local   _CLEARCOAT
			#pragma shader_feature_local_fragment _OCCLUSION
			#pragma shader_feature_local _SHADER_PBR _SHADER_PLANT
			#pragma shader_feature_local_fragment _SAMPLE_COMMON _SAMPLE_NOISETILING _SAMPLE_HEXAGONTILING _SAMPLE_ONESAMPLEONTILING
			#pragma shader_feature_local_vertex _WINDQUALITY_NONE _WINDQUALITY_FASTEST _WINDQUALITY_FAST _WINDQUALITY_BETTER _WINDQUALITY_BEST _WINDQUALITY_PALM
			#pragma shader_feature_local  
			#pragma shader_feature_local_vertex   _HOUDINI_VAT_SOFT
			#pragma shader_feature_local_fragment _PARALLAXMAP_OFF _PARALLAXMAP


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _DetailMap3;
			sampler2D _DetailMap0;
			sampler2D _DetailMap1;
			sampler2D _DetailMap2;
			sampler2D _PositionVATMap;
			sampler2D _RotateVATMap;
			samplerCUBE _CustomReflectMap;
			sampler2D _ClearCoatMap;
			sampler2D _EmissionMixMap;
			sampler2D _ExtraMixMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;


			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 TransformObjectToWorldNormal_Ref33_g6967( float3 normalOS )
			{
				return TransformObjectToWorldNormal(normalOS,false);
			}
			
			float3 TransformWorldToTangentDir_Ref133_g6965( float3 directionWS, float3x3 TBN )
			{
				return TransformWorldToTangentDir(directionWS, TBN);
			}
			
			float2 IterativeParallaxLegacy1_g6991( float height, float2 UVs, float2 plane, float refp, float scale )
			{
				UVs += plane * scale * refp;
				UVs += (height - 1) * plane * scale;
				return UVs;
			}
			

			float4 _SelectionID;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float localPosition1_g6976 = ( 0.0 );
				float localGetPositionTransformSpaceFromObject1_g6975 = ( 0.0 );
				float3 temp_output_14_0_g6968 = ( v.positionOS.xyz + float3( 0,0,0 ) );
				float3 positionOS1_g6975 = temp_output_14_0_g6968;
				Position position1_g6975 =(Position)0;
				GetPositionTransformSpaceFromObject_float( positionOS1_g6975 , position1_g6975 );
				Position position1_g6976 =(Position)position1_g6975;
				float3 OS1_g6976 = float3( 0,0,0 );
				float3 WS1_g6976 = float3( 0,0,0 );
				float3 VS1_g6976 = float3( 0,0,0 );
				float4 CS1_g6976 = float4( 0,0,0,0 );
				float4 NDC1_g6976 = float4( 0,0,0,0 );
				float3 SS1_g6976 = float3( 0,0,0 );
				float4 DS1_g6976 = float4( 0,0,0,0 );
				float3 LS1_g6976 = float3( 0,0,0 );
				float4 SC1_g6976 = float4( 0,0,0,0 );
				Position_float( position1_g6976 , OS1_g6976 , WS1_g6976 , VS1_g6976 , CS1_g6976 , NDC1_g6976 , SS1_g6976 , DS1_g6976 , LS1_g6976 , SC1_g6976 );
				float4 vertexPositionCS382_g6964 = CS1_g6976;
				float4 temp_output_478_313 = vertexPositionCS382_g6964;
				
				float2 break242 = ( ( v.ase_texcoord.xy * _BaseMap_ST.xy ) + _BaseMap_ST.zw );
				float vertexToFrag237 = break242.x;
				o.ase_texcoord.x = vertexToFrag237;
				float vertexToFrag236 = break242.y;
				o.ase_texcoord.y = vertexToFrag236;
				float3 temp_output_345_7_g6964 = WS1_g6976;
				float3 vertexPositionWS386_g6964 = temp_output_345_7_g6964;
				float3 normalizeResult129_g6964 = ASESafeNormalize( ( _WorldSpaceCameraPos - vertexPositionWS386_g6964 ) );
				float3 temp_output_43_0_g6965 = normalizeResult129_g6964;
				float3 directionWS133_g6965 = temp_output_43_0_g6965;
				float3 temp_output_43_0_g6966 = ( v.ase_tangent.xyz + float3( 0,0,0 ) );
				float3 objToWorldDir42_g6966 = mul( GetObjectToWorldMatrix(), float4( temp_output_43_0_g6966, 0 ) ).xyz;
				float3 normalizeResult128_g6966 = ASESafeNormalize( objToWorldDir42_g6966 );
				float3 VertexTangentlWS474_g6964 = normalizeResult128_g6966;
				float3 temp_output_31_0_g6967 = ( v.normalOS + float3( 0,0,0 ) );
				float3 normalOS33_g6967 = temp_output_31_0_g6967;
				float3 localTransformObjectToWorldNormal_Ref33_g6967 = TransformObjectToWorldNormal_Ref33_g6967( normalOS33_g6967 );
				float3 normalizeResult140_g6967 = ASESafeNormalize( localTransformObjectToWorldNormal_Ref33_g6967 );
				float3 temp_output_515_34_g6964 = normalizeResult140_g6967;
				float3 VertexNormalWS314_g6964 = temp_output_515_34_g6964;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 normalizeResult473_g6964 = ASESafeNormalize( ( cross( VertexNormalWS314_g6964 , VertexTangentlWS474_g6964 ) * ase_vertexTangentSign ) );
				float3 VertexBitangentWS476_g6964 = normalizeResult473_g6964;
				float3x3 temp_output_103_0_g6965 = float3x3(VertexTangentlWS474_g6964, VertexBitangentWS476_g6964, VertexNormalWS314_g6964);
				float3x3 TBN133_g6965 = temp_output_103_0_g6965;
				float3 localTransformWorldToTangentDir_Ref133_g6965 = TransformWorldToTangentDir_Ref133_g6965( directionWS133_g6965 , TBN133_g6965 );
				float3 normalizeResult132_g6965 = ASESafeNormalize( localTransformWorldToTangentDir_Ref133_g6965 );
				float3 break336_g6964 = normalizeResult132_g6965;
				float vertexToFrag264_g6964 = break336_g6964.x;
				o.ase_texcoord.z = vertexToFrag264_g6964;
				float vertexToFrag337_g6964 = break336_g6964.y;
				o.ase_texcoord.w = vertexToFrag337_g6964;
				float vertexToFrag338_g6964 = break336_g6964.z;
				o.ase_texcoord1.x = vertexToFrag338_g6964;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.yzw = 0;

				o.positionCS = temp_output_478_313;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float vertexToFrag237 = IN.ase_texcoord.x;
				float vertexToFrag236 = IN.ase_texcoord.y;
				float2 appendResult238 = (float2(vertexToFrag237 , vertexToFrag236));
				float2 uv_primitive310 = appendResult238;
				float4 tex2DNode94 = tex2D( _HeightMap, uv_primitive310 );
				float2 temp_output_3_0_g2109 = uv_primitive310;
				float2 uv2_g2109 = temp_output_3_0_g2109;
				sampler2D tex2_g2109 = _HeightMap;
				float _ScaleOrRotate154 = _ScaleOrRotate;
				float simpleNoise1_g2109 = SimpleNoise( temp_output_3_0_g2109*_ScaleOrRotate154 );
				simpleNoise1_g2109 = simpleNoise1_g2109*2 - 1;
				float noise2_g2109 = simpleNoise1_g2109;
				float4 localSampleSupportNoTileing_twoSample2_g2109 = SampleSupportNoTileing_twoSample( uv2_g2109 , tex2_g2109 , noise2_g2109 );
				float2 uv1_g2108 = uv_primitive310;
				sampler2D tex1_g2108 = _HeightMap;
				float scaleOrRotate1_g2108 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g2108 = SampleSupportNoTileing_HexagonSample( uv1_g2108 , tex1_g2108 , scaleOrRotate1_g2108 );
				float2 uv1_g2110 = uv_primitive310;
				sampler2D tex1_g2110 = _HeightMap;
				float2 positionDSxy1_g2110 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g2110 = SampleSupportNoTileing_OneSample( uv1_g2110 , tex1_g2110 , positionDSxy1_g2110 );
				#if defined(_SAMPLE_COMMON)
				float staticSwitch332 = ( ( tex2DNode94.r + tex2DNode94.g + tex2DNode94.b + tex2DNode94.a ) / 4.0 );
				#elif defined(_SAMPLE_NOISETILING)
				float staticSwitch332 = (localSampleSupportNoTileing_twoSample2_g2109).x;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_HexagonSample1_g2108).x;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_OneSample1_g2110).x;
				#else
				float staticSwitch332 = 0.0;
				#endif
				float height308 = staticSwitch332;
				float height1_g6991 = height308;
				float2 UVs1_g6991 = uv_primitive310;
				float vertexToFrag264_g6964 = IN.ase_texcoord.z;
				float vertexToFrag337_g6964 = IN.ase_texcoord.w;
				float vertexToFrag338_g6964 = IN.ase_texcoord1.x;
				float3 appendResult340_g6964 = (float3(vertexToFrag264_g6964 , vertexToFrag337_g6964 , vertexToFrag338_g6964));
				float3 normalizeResult451_g6964 = normalize( appendResult340_g6964 );
				float3 viewDirTS311 = normalizeResult451_g6964;
				float3 break6_g6991 = viewDirTS311;
				float2 appendResult5_g6991 = (float2(break6_g6991.x , break6_g6991.y));
				float2 plane1_g6991 = ( appendResult5_g6991 / break6_g6991.z );
				float refp1_g6991 = 0.5;
				float scale1_g6991 = _Parallax;
				float2 localIterativeParallaxLegacy1_g6991 = IterativeParallaxLegacy1_g6991( height1_g6991 , UVs1_g6991 , plane1_g6991 , refp1_g6991 , scale1_g6991 );
				#if defined(_PARALLAXMAP_OFF)
				float2 staticSwitch92 = uv_primitive310;
				#elif defined(_PARALLAXMAP)
				float2 staticSwitch92 = localIterativeParallaxLegacy1_g6991;
				#else
				float2 staticSwitch92 = uv_primitive310;
				#endif
				float2 UV313 = staticSwitch92;
				float2 temp_output_3_0_g6997 = UV313;
				float2 uv2_g6997 = temp_output_3_0_g6997;
				sampler2D tex2_g6997 = _BaseMap;
				float simpleNoise1_g6997 = SimpleNoise( temp_output_3_0_g6997*_ScaleOrRotate154 );
				simpleNoise1_g6997 = simpleNoise1_g6997*2 - 1;
				float noise2_g6997 = simpleNoise1_g6997;
				float4 localSampleSupportNoTileing_twoSample2_g6997 = SampleSupportNoTileing_twoSample( uv2_g6997 , tex2_g6997 , noise2_g6997 );
				float2 uv1_g6998 = UV313;
				sampler2D tex1_g6998 = _BaseMap;
				float scaleOrRotate1_g6998 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6998 = SampleSupportNoTileing_HexagonSample( uv1_g6998 , tex1_g6998 , scaleOrRotate1_g6998 );
				float2 uv1_g6996 = UV313;
				sampler2D tex1_g6996 = _BaseMap;
				float2 positionDSxy1_g6996 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g6996 = SampleSupportNoTileing_OneSample( uv1_g6996 , tex1_g6996 , positionDSxy1_g6996 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch127 = tex2D( _BaseMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_twoSample2_g6997;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_HexagonSample1_g6998;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_OneSample1_g6996;
				#else
				float4 staticSwitch127 = float4( 0,0,0,0 );
				#endif
				float4 break198 = staticSwitch127;
				float alpha202 = break198.a;
				

				surfaceDescription.Alpha = alpha202;
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;
				outColor = _SelectionID;

				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormalsOnly" }

			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_SRP_VERSION 140009


			CBUFFER_START(UnityPerMaterial)
			float4 _BaseColor;
			float4 RenderStateGroup2;
			float4 _BaseMap_ST;
			float4 _EmissionColor;
			float4 _HueVariationColor;
			float4 _SubsurfaceColor;
			float4 _SpecColor;
			float _ClearCoatSmoothness;
			float _ClearCoatMask;
			float _OcclusionStrength;
			float _Metallic;
			float _DetailOcclusionStrength2;
			float _HorizonOcclusion;
			float EmissionGI_GUI;
			float _SubsurfaceIndirect;
			float ExtraMixMap_Display;
			float _LogicalKeywordList;
			float _ScaleOrRotate;
			float _HoudiniFPS;
			float _BoundMin_Z;
			float _BoundMin_Y;
			float _BoundMin_X;
			float _DetailNormalScale2;
			float _DetailOcclusionStrength3;
			float _DetailNormalScale3;
			float _DetailOcclusionStrength0;
			float _DetailNormalScale0;
			float _DetailOcclusionStrength1;
			float _DetailNormalScale1;
			float _Parallax;
			float _AnimatorStrength;
			float _DisplayFrame;
			float _AutoPlay;
			float _IsPosTexHDR;
			float _FrameCount;
			float _BoundMax_X;
			float _BoundMax_Y;
			float _BoundMax_Z;
			float _PlaySpeed;
			float _BumpScale;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			
			#pragma vertex vert
			#pragma fragment frag

        	#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT

			

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_NORMAL_WS

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            #if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/BaseFunctionLibrary.hlsl"
			#include "Packages/com.worldsystem/Assets/Plugins/AmplifyShaderEditorExtend/ShaderLibrary/TextureFunctionLibrary.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment   _DETAIL _DETAIL_2MULTI _DETAIL_4MULTI
			#pragma shader_feature_local   EFFECT_HUE_VARIATION
			#pragma shader_feature_local   _CLEARCOAT
			#pragma shader_feature_local_fragment _OCCLUSION
			#pragma shader_feature_local _SHADER_PBR _SHADER_PLANT
			#pragma shader_feature_local_fragment _SAMPLE_COMMON _SAMPLE_NOISETILING _SAMPLE_HEXAGONTILING _SAMPLE_ONESAMPLEONTILING
			#pragma shader_feature_local_vertex _WINDQUALITY_NONE _WINDQUALITY_FASTEST _WINDQUALITY_FAST _WINDQUALITY_BETTER _WINDQUALITY_BEST _WINDQUALITY_PALM
			#pragma shader_feature_local  
			#pragma shader_feature_local_vertex   _HOUDINI_VAT_SOFT
			#pragma shader_feature_local_fragment _PARALLAXMAP_OFF _PARALLAXMAP
			#pragma shader_feature_local EFFECT_BACKSIDE_NORMALS


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;

				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _DetailMap3;
			sampler2D _DetailMap0;
			sampler2D _DetailMap1;
			sampler2D _DetailMap2;
			sampler2D _PositionVATMap;
			sampler2D _RotateVATMap;
			samplerCUBE _CustomReflectMap;
			sampler2D _ClearCoatMap;
			sampler2D _EmissionMixMap;
			sampler2D _ExtraMixMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;
			sampler2D _NRAMap;


			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 TransformObjectToWorldNormal_Ref33_g6967( float3 normalOS )
			{
				return TransformObjectToWorldNormal(normalOS,false);
			}
			
			float3 TransformWorldToTangentDir_Ref133_g6965( float3 directionWS, float3x3 TBN )
			{
				return TransformWorldToTangentDir(directionWS, TBN);
			}
			
			float2 IterativeParallaxLegacy1_g6991( float height, float2 UVs, float2 plane, float refp, float scale )
			{
				UVs += plane * scale * refp;
				UVs += (height - 1) * plane * scale;
				return UVs;
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				
				float localPosition1_g6976 = ( 0.0 );
				float localGetPositionTransformSpaceFromObject1_g6975 = ( 0.0 );
				float3 temp_output_14_0_g6968 = ( v.positionOS.xyz + float3( 0,0,0 ) );
				float3 positionOS1_g6975 = temp_output_14_0_g6968;
				Position position1_g6975 =(Position)0;
				GetPositionTransformSpaceFromObject_float( positionOS1_g6975 , position1_g6975 );
				Position position1_g6976 =(Position)position1_g6975;
				float3 OS1_g6976 = float3( 0,0,0 );
				float3 WS1_g6976 = float3( 0,0,0 );
				float3 VS1_g6976 = float3( 0,0,0 );
				float4 CS1_g6976 = float4( 0,0,0,0 );
				float4 NDC1_g6976 = float4( 0,0,0,0 );
				float3 SS1_g6976 = float3( 0,0,0 );
				float4 DS1_g6976 = float4( 0,0,0,0 );
				float3 LS1_g6976 = float3( 0,0,0 );
				float4 SC1_g6976 = float4( 0,0,0,0 );
				Position_float( position1_g6976 , OS1_g6976 , WS1_g6976 , VS1_g6976 , CS1_g6976 , NDC1_g6976 , SS1_g6976 , DS1_g6976 , LS1_g6976 , SC1_g6976 );
				float4 vertexPositionCS382_g6964 = CS1_g6976;
				float4 temp_output_478_313 = vertexPositionCS382_g6964;
				
				float2 break242 = ( ( v.ase_texcoord.xy * _BaseMap_ST.xy ) + _BaseMap_ST.zw );
				float vertexToFrag237 = break242.x;
				o.ase_texcoord1.x = vertexToFrag237;
				float vertexToFrag236 = break242.y;
				o.ase_texcoord1.y = vertexToFrag236;
				float3 temp_output_345_7_g6964 = WS1_g6976;
				float3 vertexPositionWS386_g6964 = temp_output_345_7_g6964;
				float3 normalizeResult129_g6964 = ASESafeNormalize( ( _WorldSpaceCameraPos - vertexPositionWS386_g6964 ) );
				float3 temp_output_43_0_g6965 = normalizeResult129_g6964;
				float3 directionWS133_g6965 = temp_output_43_0_g6965;
				float3 temp_output_43_0_g6966 = ( v.ase_tangent.xyz + float3( 0,0,0 ) );
				float3 objToWorldDir42_g6966 = mul( GetObjectToWorldMatrix(), float4( temp_output_43_0_g6966, 0 ) ).xyz;
				float3 normalizeResult128_g6966 = ASESafeNormalize( objToWorldDir42_g6966 );
				float3 VertexTangentlWS474_g6964 = normalizeResult128_g6966;
				float3 temp_output_31_0_g6967 = ( v.normalOS + float3( 0,0,0 ) );
				float3 normalOS33_g6967 = temp_output_31_0_g6967;
				float3 localTransformObjectToWorldNormal_Ref33_g6967 = TransformObjectToWorldNormal_Ref33_g6967( normalOS33_g6967 );
				float3 normalizeResult140_g6967 = ASESafeNormalize( localTransformObjectToWorldNormal_Ref33_g6967 );
				float3 temp_output_515_34_g6964 = normalizeResult140_g6967;
				float3 VertexNormalWS314_g6964 = temp_output_515_34_g6964;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 normalizeResult473_g6964 = ASESafeNormalize( ( cross( VertexNormalWS314_g6964 , VertexTangentlWS474_g6964 ) * ase_vertexTangentSign ) );
				float3 VertexBitangentWS476_g6964 = normalizeResult473_g6964;
				float3x3 temp_output_103_0_g6965 = float3x3(VertexTangentlWS474_g6964, VertexBitangentWS476_g6964, VertexNormalWS314_g6964);
				float3x3 TBN133_g6965 = temp_output_103_0_g6965;
				float3 localTransformWorldToTangentDir_Ref133_g6965 = TransformWorldToTangentDir_Ref133_g6965( directionWS133_g6965 , TBN133_g6965 );
				float3 normalizeResult132_g6965 = ASESafeNormalize( localTransformWorldToTangentDir_Ref133_g6965 );
				float3 break336_g6964 = normalizeResult132_g6965;
				float vertexToFrag264_g6964 = break336_g6964.x;
				o.ase_texcoord1.z = vertexToFrag264_g6964;
				float vertexToFrag337_g6964 = break336_g6964.y;
				o.ase_texcoord1.w = vertexToFrag337_g6964;
				float vertexToFrag338_g6964 = break336_g6964.z;
				o.ase_texcoord2.x = vertexToFrag338_g6964;
				
				float3 break141_g6964 = VertexTangentlWS474_g6964;
				float vertexToFrag326_g6964 = break141_g6964.x;
				o.ase_texcoord2.y = vertexToFrag326_g6964;
				float vertexToFrag327_g6964 = break141_g6964.y;
				o.ase_texcoord2.z = vertexToFrag327_g6964;
				float vertexToFrag328_g6964 = break141_g6964.z;
				o.ase_texcoord2.w = vertexToFrag328_g6964;
				float3 break148_g6964 = VertexBitangentWS476_g6964;
				float vertexToFrag329_g6964 = break148_g6964.x;
				o.ase_texcoord3.x = vertexToFrag329_g6964;
				float vertexToFrag330_g6964 = break148_g6964.y;
				o.ase_texcoord3.y = vertexToFrag330_g6964;
				float vertexToFrag331_g6964 = break148_g6964.z;
				o.ase_texcoord3.z = vertexToFrag331_g6964;
				float3 break138_g6964 = VertexNormalWS314_g6964;
				float vertexToFrag323_g6964 = break138_g6964.x;
				o.ase_texcoord3.w = vertexToFrag323_g6964;
				float vertexToFrag324_g6964 = break138_g6964.y;
				o.ase_texcoord4.x = vertexToFrag324_g6964;
				float vertexToFrag325_g6964 = break138_g6964.z;
				o.ase_texcoord4.y = vertexToFrag325_g6964;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;

				o.positionCS = temp_output_478_313;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag( VertexOutput IN
				, out half4 outNormalWS : SV_Target0
			#ifdef _WRITE_RENDERING_LAYERS
				, out float4 outRenderingLayers : SV_Target1
			#endif
				, bool ase_vface : SV_IsFrontFace )
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float vertexToFrag237 = IN.ase_texcoord1.x;
				float vertexToFrag236 = IN.ase_texcoord1.y;
				float2 appendResult238 = (float2(vertexToFrag237 , vertexToFrag236));
				float2 uv_primitive310 = appendResult238;
				float4 tex2DNode94 = tex2D( _HeightMap, uv_primitive310 );
				float2 temp_output_3_0_g2109 = uv_primitive310;
				float2 uv2_g2109 = temp_output_3_0_g2109;
				sampler2D tex2_g2109 = _HeightMap;
				float _ScaleOrRotate154 = _ScaleOrRotate;
				float simpleNoise1_g2109 = SimpleNoise( temp_output_3_0_g2109*_ScaleOrRotate154 );
				simpleNoise1_g2109 = simpleNoise1_g2109*2 - 1;
				float noise2_g2109 = simpleNoise1_g2109;
				float4 localSampleSupportNoTileing_twoSample2_g2109 = SampleSupportNoTileing_twoSample( uv2_g2109 , tex2_g2109 , noise2_g2109 );
				float2 uv1_g2108 = uv_primitive310;
				sampler2D tex1_g2108 = _HeightMap;
				float scaleOrRotate1_g2108 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g2108 = SampleSupportNoTileing_HexagonSample( uv1_g2108 , tex1_g2108 , scaleOrRotate1_g2108 );
				float2 uv1_g2110 = uv_primitive310;
				sampler2D tex1_g2110 = _HeightMap;
				float2 positionDSxy1_g2110 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g2110 = SampleSupportNoTileing_OneSample( uv1_g2110 , tex1_g2110 , positionDSxy1_g2110 );
				#if defined(_SAMPLE_COMMON)
				float staticSwitch332 = ( ( tex2DNode94.r + tex2DNode94.g + tex2DNode94.b + tex2DNode94.a ) / 4.0 );
				#elif defined(_SAMPLE_NOISETILING)
				float staticSwitch332 = (localSampleSupportNoTileing_twoSample2_g2109).x;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_HexagonSample1_g2108).x;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float staticSwitch332 = (localSampleSupportNoTileing_OneSample1_g2110).x;
				#else
				float staticSwitch332 = 0.0;
				#endif
				float height308 = staticSwitch332;
				float height1_g6991 = height308;
				float2 UVs1_g6991 = uv_primitive310;
				float vertexToFrag264_g6964 = IN.ase_texcoord1.z;
				float vertexToFrag337_g6964 = IN.ase_texcoord1.w;
				float vertexToFrag338_g6964 = IN.ase_texcoord2.x;
				float3 appendResult340_g6964 = (float3(vertexToFrag264_g6964 , vertexToFrag337_g6964 , vertexToFrag338_g6964));
				float3 normalizeResult451_g6964 = normalize( appendResult340_g6964 );
				float3 viewDirTS311 = normalizeResult451_g6964;
				float3 break6_g6991 = viewDirTS311;
				float2 appendResult5_g6991 = (float2(break6_g6991.x , break6_g6991.y));
				float2 plane1_g6991 = ( appendResult5_g6991 / break6_g6991.z );
				float refp1_g6991 = 0.5;
				float scale1_g6991 = _Parallax;
				float2 localIterativeParallaxLegacy1_g6991 = IterativeParallaxLegacy1_g6991( height1_g6991 , UVs1_g6991 , plane1_g6991 , refp1_g6991 , scale1_g6991 );
				#if defined(_PARALLAXMAP_OFF)
				float2 staticSwitch92 = uv_primitive310;
				#elif defined(_PARALLAXMAP)
				float2 staticSwitch92 = localIterativeParallaxLegacy1_g6991;
				#else
				float2 staticSwitch92 = uv_primitive310;
				#endif
				float2 UV313 = staticSwitch92;
				float2 temp_output_3_0_g6997 = UV313;
				float2 uv2_g6997 = temp_output_3_0_g6997;
				sampler2D tex2_g6997 = _BaseMap;
				float simpleNoise1_g6997 = SimpleNoise( temp_output_3_0_g6997*_ScaleOrRotate154 );
				simpleNoise1_g6997 = simpleNoise1_g6997*2 - 1;
				float noise2_g6997 = simpleNoise1_g6997;
				float4 localSampleSupportNoTileing_twoSample2_g6997 = SampleSupportNoTileing_twoSample( uv2_g6997 , tex2_g6997 , noise2_g6997 );
				float2 uv1_g6998 = UV313;
				sampler2D tex1_g6998 = _BaseMap;
				float scaleOrRotate1_g6998 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6998 = SampleSupportNoTileing_HexagonSample( uv1_g6998 , tex1_g6998 , scaleOrRotate1_g6998 );
				float2 uv1_g6996 = UV313;
				sampler2D tex1_g6996 = _BaseMap;
				float2 positionDSxy1_g6996 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g6996 = SampleSupportNoTileing_OneSample( uv1_g6996 , tex1_g6996 , positionDSxy1_g6996 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch127 = tex2D( _BaseMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_twoSample2_g6997;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_HexagonSample1_g6998;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch127 = localSampleSupportNoTileing_OneSample1_g6996;
				#else
				float4 staticSwitch127 = float4( 0,0,0,0 );
				#endif
				float4 break198 = staticSwitch127;
				float alpha202 = break198.a;
				
				float2 temp_output_3_0_g6993 = UV313;
				float2 uv2_g6993 = temp_output_3_0_g6993;
				sampler2D tex2_g6993 = _NRAMap;
				float simpleNoise1_g6993 = SimpleNoise( temp_output_3_0_g6993*_ScaleOrRotate154 );
				simpleNoise1_g6993 = simpleNoise1_g6993*2 - 1;
				float noise2_g6993 = simpleNoise1_g6993;
				float4 localSampleSupportNoTileing_twoSample2_g6993 = SampleSupportNoTileing_twoSample( uv2_g6993 , tex2_g6993 , noise2_g6993 );
				float2 uv1_g6994 = UV313;
				sampler2D tex1_g6994 = _NRAMap;
				float scaleOrRotate1_g6994 = _ScaleOrRotate154;
				float4 localSampleSupportNoTileing_HexagonSample1_g6994 = SampleSupportNoTileing_HexagonSample( uv1_g6994 , tex1_g6994 , scaleOrRotate1_g6994 );
				float2 uv1_g6992 = UV313;
				sampler2D tex1_g6992 = _NRAMap;
				float2 positionDSxy1_g6992 = half4(0,0,0,0).xy;
				float4 localSampleSupportNoTileing_OneSample1_g6992 = SampleSupportNoTileing_OneSample( uv1_g6992 , tex1_g6992 , positionDSxy1_g6992 );
				#if defined(_SAMPLE_COMMON)
				float4 staticSwitch164 = tex2D( _NRAMap, UV313 );
				#elif defined(_SAMPLE_NOISETILING)
				float4 staticSwitch164 = localSampleSupportNoTileing_twoSample2_g6993;
				#elif defined(_SAMPLE_HEXAGONTILING)
				float4 staticSwitch164 = localSampleSupportNoTileing_HexagonSample1_g6994;
				#elif defined(_SAMPLE_ONESAMPLEONTILING)
				float4 staticSwitch164 = localSampleSupportNoTileing_OneSample1_g6992;
				#else
				float4 staticSwitch164 = float4( 0,0,0,0 );
				#endif
				float4 break205 = staticSwitch164;
				float2 appendResult206 = (float2(break205.r , break205.g));
				float2 normalMapRG1_g6995 = appendResult206;
				float4 localDecodeNormalRG1_g6995 = DecodeNormalRG( normalMapRG1_g6995 );
				float3 unpack4_g6995 = UnpackNormalScale( localDecodeNormalRG1_g6995, ( _BumpScale + 1.0 ) );
				unpack4_g6995.z = lerp( 1, unpack4_g6995.z, saturate(( _BumpScale + 1.0 )) );
				float3 normalTS208 = unpack4_g6995;
				float vertexToFrag326_g6964 = IN.ase_texcoord2.y;
				float vertexToFrag327_g6964 = IN.ase_texcoord2.z;
				float vertexToFrag328_g6964 = IN.ase_texcoord2.w;
				float3 appendResult134_g6964 = (float3(vertexToFrag326_g6964 , vertexToFrag327_g6964 , vertexToFrag328_g6964));
				float3 normalizeResult448_g6964 = normalize( appendResult134_g6964 );
				float3 TangentWS315_g6964 = normalizeResult448_g6964;
				float vertexToFrag329_g6964 = IN.ase_texcoord3.x;
				float vertexToFrag330_g6964 = IN.ase_texcoord3.y;
				float vertexToFrag331_g6964 = IN.ase_texcoord3.z;
				float3 appendResult144_g6964 = (float3(vertexToFrag329_g6964 , vertexToFrag330_g6964 , vertexToFrag331_g6964));
				float3 normalizeResult449_g6964 = normalize( appendResult144_g6964 );
				float3 BitangentWS316_g6964 = normalizeResult449_g6964;
				float vertexToFrag323_g6964 = IN.ase_texcoord3.w;
				float vertexToFrag324_g6964 = IN.ase_texcoord4.x;
				float vertexToFrag325_g6964 = IN.ase_texcoord4.y;
				float3 appendResult142_g6964 = (float3(vertexToFrag323_g6964 , vertexToFrag324_g6964 , vertexToFrag325_g6964));
				float3 normalizeResult459_g6964 = normalize( appendResult142_g6964 );
				float3 NormalWS388_g6964 = normalizeResult459_g6964;
				float3x3 TBN220 = float3x3(TangentWS315_g6964, BitangentWS316_g6964, NormalWS388_g6964);
				float3 normalizeResult320 = normalize( mul( normalTS208, TBN220 ) );
				float isFront317 = ase_vface;
				#ifdef EFFECT_BACKSIDE_NORMALS
				float3 staticSwitch58 = ( (float)(int)isFront317 != 0.0 ? normalizeResult320 : -normalizeResult320 );
				#else
				float3 staticSwitch58 = normalizeResult320;
				#endif
				float3 normalWS224 = staticSwitch58;
				

				surfaceDescription.Alpha = alpha202;
				surfaceDescription.AlphaClipThreshold = 0.5;
                float3 WorldNormal = normalWS224;

				#if _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float3 normalWS = normalize(WorldNormal);
					float2 octNormalWS = PackNormalOctQuadEncode(normalWS);           // values between [-1, +1], must use fp32 on some platforms
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);   // values between [ 0,  1]
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);      // values between [ 0,  1]
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					float3 normalWS = WorldNormal;
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4(EncodeMeshRenderingLayer(renderingLayers), 0, 0, 0);
				#endif
			}

			ENDHLSL
		}

		
	}
	
	CustomEditor "LogicalSGUI.LogicalSGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}
/*ASEBEGIN
Version=19302
Node;AmplifyShaderEditor.CommentaryNode;121;-6712.862,-1222.023;Inherit;False;2821.902;4145.219;Comment;95;75;74;189;186;233;184;193;190;188;187;73;72;69;67;270;272;283;71;269;271;275;274;70;273;268;181;232;180;66;175;179;178;177;183;61;210;217;224;315;58;320;319;318;208;248;51;314;201;202;60;212;211;231;155;64;216;215;200;198;127;52;156;153;140;249;322;207;209;206;213;59;205;164;163;162;161;55;167;234;168;310;238;237;236;242;241;240;243;239;228;56;388;389;426;387;着色器模型properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;56;-6596.004,-920.0909;Inherit;True;Property;_BaseMap;基础贴图;4;0;Create;False;0;0;0;True;3;Title(ShaderModelGroup1, Albedo Alpha);MainTexture;LogicalTex(ShaderModelGroup1, true, RGB_A, _);False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;228;-6169.891,-918.4715;Inherit;False;baseMap;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;239;-5847.303,-992.7264;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureTransformNode;243;-5861.482,-859.11;Inherit;False;-1;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-5596.955,-955.491;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;241;-5428.028,-912.1108;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;242;-5294.772,-916.9367;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.VertexToFragmentNode;236;-5141.92,-847.2185;Inherit;False;False;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;237;-5143.696,-926.0538;Inherit;False;False;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;120;-10953.79,-1212.924;Inherit;False;820.6211;746.7925;Comment;4;45;47;154;50;渲染状态properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;238;-4924.284,-912.5563;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-10912.44,-661.1305;Inherit;False;Property;_ScaleOrRotate;缩放/旋转;2;0;Create;False;0;0;0;True;1;LogicalSub(RenderStateGroup2_SAMPLE_NOISETILING or RenderStateGroup2_SAMPLE_HEXAGONTILING indent);False;0.3;0.3;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;123;-9300.913,-1168.002;Inherit;False;2225.218;1569.251;Comment;23;424;308;423;332;94;95;93;313;92;353;348;312;96;335;334;333;326;327;328;330;304;331;325;视差(UV)properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;310;-4732.555,-909.0411;Inherit;False;uv_primitive;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-10587.49,-661.8;Inherit;False;_ScaleOrRotate;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;325;-9124.833,-856.8271;Inherit;True;Property;_HeightMap;视差贴图(高度);43;0;Create;False;0;0;0;False;1;LogicalTex(ParallaxGroup0_PARALLAXMAP and ParallaxGroup0_USE_PARALLAXMAP_PARALLAX, false, RGB_A, _);False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;304;-9193.783,-647.5818;Inherit;False;310;uv_primitive;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;331;-9012.551,-340.6446;Inherit;False;154;_ScaleOrRotate;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateFragmentDataNode;330;-9207.832,-528.3082;Inherit;False;0;1;positionCS;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;94;-8451.155,-829.0771;Inherit;True;Property;_HeightMap02;视差贴图(高度);49;0;Create;False;0;0;0;False;1;LogicalTex(ParallaxGroup0_PARALLAXMAP and ParallaxGroup0_USE_PARALLAXMAP_PARALLAX, false, RGB_A, _);False;-1;None;None;True;0;False;linearGrey;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;328;-8493.144,-390.4443;Inherit;False;SampleSupportNoTileing_HexagonSample;-1;;2108;2be24d88e4fca7d4d85f800f408556e7;0;3;2;FLOAT2;0,0;False;3;SAMPLER2D;0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;327;-8483.568,-510.4539;Inherit;False;SampleSupportNoTileing_twoSample;-1;;2109;bdfdef6c25be0344dbc4ba61cf1c3986;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;;False;5;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;326;-8482.743,-629.3155;Inherit;False;SampleSupportNoTileing_OneSample;-1;;2110;dd8b7457939c2a44e9e4de0a0843db12;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;0,0;False;5;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;423;-8113.926,-803.24;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;333;-8051.371,-626.0117;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;334;-8055.27,-537.6118;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;335;-8055.27,-437.3115;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;424;-7975.926,-800.24;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;332;-7775.147,-680.459;Inherit;False;Property;Sample_Enum5;关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复;1;0;Create;False;0;0;0;True;0;False;0;1;1;True;;LogicalSubKeywordEnum;5;RenderStateGroup2_SurfaceOptions;_;_SAMPLE_NOISETILING;_SAMPLE_HEXAGONTILING;_SAMPLE_ONESAMPLEONTILING;Reference;47;True;True;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;478;280.3777,-328.9806;Inherit;False;Model_EX04;-1;;6964;db2a50576abc55b4182a85385bad6f66;8,430,0,511,0,512,0,514,0,513,0,505,0,431,0,552,0;7;307;FLOAT3;0,0,0;False;432;FLOAT3;0,0,0;False;377;FLOAT3;0,0,0;False;433;FLOAT3;0,0,0;False;554;FLOAT3;0,0,0;False;555;FLOAT3;0,0,0;False;556;FLOAT3;0,0,0;False;39;FLOAT2;543;FLOAT3;546;FLOAT;547;FLOAT4;347;FLOAT4;313;FLOAT4;413;FLOAT4;415;FLOAT2;273;FLOAT2;275;FLOAT3;277;FLOAT;410;FLOAT3;285;FLOAT4;243;FLOAT4;178;FLOAT3;0;FLOAT3;4;FLOAT3;5;FLOAT3x3;6;FLOAT3;312;FLOAT3;156;FLOAT3;271;FLOAT3;229;FLOAT3;7;FLOAT3;185;FLOAT3;194;FLOAT3;197;FLOAT3;11;FLOAT;21;FLOAT;540;FLOAT;541;FLOAT;542;FLOAT;22;INT;202;FLOAT4;224;FLOAT4;225;FLOAT3;220;INT;216;INT;217;INT;219
Node;AmplifyShaderEditor.RegisterLocalVarNode;308;-7318.987,-680.157;Inherit;False;height;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;311;1068.055,795.851;Inherit;False;viewDirTS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-8932.399,111.1657;Inherit;False;Property;_Parallax;视差强度;45;0;Create;False;0;0;0;True;1;LogicalSub(ParallaxGroup0_PARALLAXMAP);False;0;0.1;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;312;-8866.876,6.33357;Inherit;False;311;viewDirTS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;348;-8858.741,-79.20041;Inherit;False;308;height;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;353;-8513.037,-60.28094;Inherit;False;ParallaxMapping;-1;;6991;828cd39fcb68245479af3f7728c1427b;0;5;2;FLOAT;0;False;3;FLOAT2;0,0;False;8;FLOAT3;0,0,0;False;9;FLOAT;0.5;False;10;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;92;-8200.54,-134.7653;Inherit;False;Property;ParallaxGroup0;禁用/视差偏移/视差(UV);41;0;Create;False;0;0;0;True;0;False;0;0;0;True;;EnumGroup;2;Off disable_ParallaxSource_Enum, _PARALLAXMAP_OFF;ParallaxOffset, _PARALLAXMAP;Create;True;True;Fragment;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;313;-7528.658,-137.2726;Inherit;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;168;-6658.053,-197.0579;Inherit;True;Property;_NRAMap;NRA贴图#通用PBR:(法线, 粗糙度, AO)#场景-植物:(法线, 粗糙度, AO);7;0;Create;False;0;0;0;True;2;Title(ShaderModelGroup1, Normal Roughness Occlusion);LogicalTex(ShaderModelGroup1, false, RG_B_A, _);False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TemplateFragmentDataNode;234;-6625.062,135.9574;Inherit;False;0;1;positionCS;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;167;-6644.781,313.6207;Inherit;False;154;_ScaleOrRotate;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;315;-6573.097,35.2081;Inherit;False;313;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;55;-6273.805,-180.9253;Inherit;True;Property;_NRAMap02;NRA贴图;9;0;Create;False;0;0;0;False;2;Title(ShaderModelGroup1, Normal Roughness Occlusion);LogicalTex(ShaderModelGroup1, false, RG_B_A, _);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;161;-6214.881,12.44971;Inherit;False;SampleSupportNoTileing_OneSample;-1;;6992;dd8b7457939c2a44e9e4de0a0843db12;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;0,0;False;5;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;162;-6215.707,131.3115;Inherit;False;SampleSupportNoTileing_twoSample;-1;;6993;bdfdef6c25be0344dbc4ba61cf1c3986;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;;False;5;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;163;-6225.282,251.3208;Inherit;False;SampleSupportNoTileing_HexagonSample;-1;;6994;2be24d88e4fca7d4d85f800f408556e7;0;3;2;FLOAT2;0,0;False;3;SAMPLER2D;0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;164;-5641.191,-166.8381;Inherit;False;Property;Sample_Enum2;关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复;1;0;Create;False;0;0;0;True;0;False;0;1;1;True;;LogicalSubKeywordEnum;5;RenderStateGroup2_SurfaceOptions;_;_SAMPLE_NOISETILING;_SAMPLE_HEXAGONTILING;_SAMPLE_ONESAMPLEONTILING;Reference;47;True;True;Fragment;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;205;-5197.806,-149.9032;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;59;-5473.684,45.33562;Inherit;False;Property;_BumpScale;法线强度;9;0;Create;False;0;0;0;False;1;LogicalSub(ShaderModelGroup1);False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-5361.781,242.3767;Inherit;False;Constant;_Float2;Float 2;69;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;206;-5081.806,-149.9032;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;209;-5187.355,41.78725;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;220;1050.869,635.0745;Inherit;False;TBN;-1;True;1;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.FunctionNode;207;-4937.806,-145.9032;Inherit;False;DecodeNormalRG;-1;;6995;369339b99dd84204b97be658d76839ca;0;2;2;FLOAT2;0,0;False;3;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;208;-4663.448,-142.6815;Inherit;False;normalTS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;319;-4632.945,-61.60727;Inherit;False;220;TBN;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;318;-4458.945,-122.6073;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-6546.849,-357.4633;Inherit;False;154;_ScaleOrRotate;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateFragmentDataNode;231;-6606.326,-537.7451;Inherit;False;0;1;positionCS;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;317;1071.288,964.2002;Inherit;False;isFront;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;314;-6573.295,-661.6767;Inherit;False;313;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalizeNode;320;-4320.945,-122.6073;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;140;-6212.95,-616.635;Inherit;False;SampleSupportNoTileing_OneSample;-1;;6996;dd8b7457939c2a44e9e4de0a0843db12;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;0,0;False;5;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;153;-6213.775,-497.773;Inherit;False;SampleSupportNoTileing_twoSample;-1;;6997;bdfdef6c25be0344dbc4ba61cf1c3986;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;;False;5;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;156;-6223.349,-377.7633;Inherit;False;SampleSupportNoTileing_HexagonSample;-1;;6998;2be24d88e4fca7d4d85f800f408556e7;0;3;2;FLOAT2;0,0;False;3;SAMPLER2D;0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;52;-6198.861,-809.8947;Inherit;True;Property;_BaseMap01;基础贴图;6;0;Create;False;0;0;0;False;3;Title(ShaderModelGroup1, Albedo Alpha);MainTexture;LogicalTex(ShaderModelGroup1, true, RGB_A, _);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;322;-5039.903,-399.1647;Inherit;False;317;isFront;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;249;-5007.93,-304.8098;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;127;-5775.477,-689.75;Inherit;False;Property;Sample_Enum1;关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复;1;0;Create;False;0;0;0;True;0;False;0;1;1;True;;LogicalSubKeywordEnum;5;RenderStateGroup2_SurfaceOptions;_;_SAMPLE_NOISETILING;_SAMPLE_HEXAGONTILING;_SAMPLE_ONESAMPLEONTILING;Reference;47;True;True;Fragment;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;248;-4815,-390.6239;Inherit;False;If;-1;;6999;58db534cb7946664eb869bdc1abdfb5a;0;3;7;INT;1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;198;-5302.449,-684.0736;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LWGUIStaticSwitch;58;-4609.685,-400.3263;Inherit;False;Property;FlipBackNormal_On;翻转背面法线;8;0;Create;False;0;0;0;True;0;False;0;0;0;True;ShaderModelGroup1_senior, EFFECT_BACKSIDE_NORMALS;LogicalSubToggle;2;Key0;Key1;Create;True;False;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;126;-1172.063,-1186.943;Inherit;False;420;448.3723;Comment;3;119;118;117;色调变体properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;125;-3805.463,-1205.569;Inherit;False;1753.321;780.905;Comment;18;296;292;297;356;355;290;289;354;293;295;294;112;116;115;291;113;288;428;清漆properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;124;-1953.638,-1267.392;Inherit;False;652.0459;1911.89;Comment;13;98;104;105;102;101;106;103;99;111;110;108;107;109;细节properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;122;-9999.406,-1209.941;Inherit;False;484;1497.098;Comment;16;77;78;83;82;81;80;79;85;86;87;88;89;90;91;84;76;Houdini顶点动画贴图(VAT)properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;202;-5138.448,-592.0736;Inherit;False;alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;224;-4139.515,-396.4013;Inherit;False;normalWS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;109;-1886.299,-52.1955;Inherit;True;Property;_DetailMap3;4-细节贴图;56;0;Create;False;0;0;0;True;2;LogicalTitle(DetailGroup0_DETAIL_4MULTI, Detail Four Layer);LogicalTex(DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;107;-1894.733,-204.1134;Inherit;False;Property;_DetailOcclusionStrength2;3-细节遮蔽强度;54;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-1891.733,-132.1135;Inherit;False;Property;_DetailNormalScale2;3-细节法线强度;55;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-1883.799,143.3045;Inherit;False;Property;_DetailOcclusionStrength3;4-细节遮蔽强度;57;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-1880.798,215.3044;Inherit;False;Property;_DetailNormalScale3;4-细节法线强度;58;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;-1899.798,-1076.813;Inherit;True;Property;_DetailMap0;1-细节贴图;47;0;Create;False;0;0;0;True;1;LogicalTex(DetailGroup0_DETAIL or DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;103;-1900.798,-736.8131;Inherit;True;Property;_DetailMap1;2-细节贴图;50;0;Create;False;0;0;0;True;2;LogicalTitle(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI, Detail Two Layer);LogicalTex(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;106;-1897.233,-399.6129;Inherit;True;Property;_DetailMap2;3-细节贴图;53;0;Create;False;0;0;0;True;2;LogicalTitle(DetailGroup0_DETAIL_4MULTI, Detail Three Layer);LogicalTex(DetailGroup0_DETAIL_4MULTI, true, RG_B_A, _);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;101;-1895.797,-889.8127;Inherit;False;Property;_DetailOcclusionStrength0;1-细节遮蔽强度;48;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL or DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-1896.797,-816.8129;Inherit;False;Property;_DetailNormalScale0;1-细节法线强度;49;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL or DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-1898.297,-555.313;Inherit;False;Property;_DetailOcclusionStrength1;2-细节遮蔽强度;52;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-1899.298,-480.3133;Inherit;False;Property;_DetailNormalScale1;2-细节法线强度;51;0;Create;False;0;0;0;True;1;LogicalSub(DetailGroup0_DETAIL_2MULTI or DetailGroup0_DETAIL_4MULTI);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;98;-1903.639,-1217.392;Inherit;False;Property;DetailGroup0;禁用/一层细节/两层细节/四层细节/细节;46;0;Create;False;0;0;0;True;0;False;0;0;0;True;;EnumGroup;4;Off, _;Detail1Multi, _DETAIL;Detail2Multi, _DETAIL_2MULTI;Detail4Multi, _DETAIL_4MULTI;Create;True;True;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;118;-1121.972,-1030.611;Inherit;False;Property;_HueVariationColor;色调变体颜色;64;0;Create;False;0;0;0;True;1;LogicalSub(HueVariationGroup0EFFECT_HUE_VARIATION);False;1,0.5,0,0.1019608;1,0.5019608,0,0.1019608;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LWGUIStaticSwitch;117;-1122.063,-1136.943;Inherit;False;Property;HueVariationGroup0;禁用/开启/色调变体;63;0;Create;False;0;0;0;True;0;False;0;0;0;True;;EnumGroup;2;Off, _;On, EFFECT_HUE_VARIATION;Create;True;False;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;77;-9930.354,-1038.813;Inherit;True;Property;_PositionVATMap;VAT位置贴图;26;0;Create;False;0;0;0;True;1;LogicalTex(HoudiniVATGroup0_HOUDINI_VAT_SOFT, false, RGB_A, _);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;78;-9937.159,-855.0785;Inherit;True;Property;_RotateVATMap;VAT旋转贴图;27;0;Create;False;0;0;0;True;1;LogicalTex(HoudiniVATGroup0_HOUDINI_VAT_SOFT, false, RGB_A, _);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;83;-9898.793,-388.8425;Inherit;False;Property;_AnimatorStrength;动画幅度;32;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-9903.793,-457.8425;Inherit;False;Property;_PlaySpeed;播放速度;31;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-9908.793,-522.8427;Inherit;False;Property;_DisplayFrame;显示帧;30;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-9905.793,-591.8423;Inherit;False;Property;_AutoPlay;自动播放;29;0;Create;False;0;0;0;True;1;LogicalSubToggle(HoudiniVATGroup0_HOUDINI_VAT_SOFT, _);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-9921.438,-662.8221;Inherit;False;Property;_IsPosTexHDR;位置贴图使用HDR;28;0;Create;False;0;0;0;True;1;LogicalSubToggle(HoudiniVATGroup0_HOUDINI_VAT_SOFT, _);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-9910.793,-248.8422;Inherit;False;Property;_FrameCount;Frame Count;34;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-9910.793,-177.8422;Inherit;False;Property;_BoundMax_X;Bound Max X;35;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-9908.793,-117.8421;Inherit;False;Property;_BoundMax_Y;Bound Max Y;36;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-9907.793,-42.84221;Inherit;False;Property;_BoundMax_Z;Bound Max Z;37;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-9911.793,27.15763;Inherit;False;Property;_BoundMin_X;Bound Min X;38;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-9902.793,100.158;Inherit;False;Property;_BoundMin_Y;Bound Min Y;39;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-9903.793,174.1579;Inherit;False;Property;_BoundMin_Z;Bound Min Z;40;0;Create;False;0;0;0;True;1;LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-9911.793,-313.8423;Inherit;False;Property;_HoudiniFPS;Houdini FPS;33;0;Create;False;0;0;0;True;2;Title(HoudiniVATGroup0_HOUDINI_VAT_SOFT, Houdini VAT Data);LogicalSub(HoudiniVATGroup0_HOUDINI_VAT_SOFT);False;24;24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;47;-10900.47,-935.5577;Inherit;False;Property;Sample_Enum;关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复;1;0;Create;False;0;0;0;False;0;False;0;0;0;True;;LogicalSubKeywordEnum;5;RenderStateGroup2_SurfaceOptions;_SAMPLE_COMMON;_SAMPLE_NOISETILING;_SAMPLE_HEXAGONTILING;_SAMPLE_ONESAMPLEONTILING;Create;True;True;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;45;-10902.79,-1150.924;Inherit;False;Property;RenderStateGroup2;表面选项/渲染状态;0;0;Create;False;0;0;0;True;1;EnumGroup(RenderStateGroup2, _SENIOR, SurfaceOptions, _SurfaceOptions);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;291;-3384.781,-857.202;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-3646.939,-747.3712;Inherit;False;Property;_ClearCoatSmoothness;清漆粗糙度;62;0;Create;False;0;0;0;True;1;LogicalSub(ClearCoatGroup0_CLEARCOAT);False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;93;-8774.935,-1027.824;Inherit;False;Property;ParallaxSource_Enum;高度贴图/额外贴图/高度数据源;42;0;Create;False;0;0;0;False;0;False;0;1;1;True;;LogicalSubKeywordEnum;3;ParallaxGroup0_PARALLAXMAP;_USE_PARALLAXMAP_PARALLAX;_USE_EXTRAMIXMAP_PARALLAX;Create;True;True;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;95;-9046.813,-1050.855;Inherit;False;Property;_UseMixMapChannel_Parallax;使用混合贴图通道;44;0;Create;False;0;0;0;False;1;LogicalChannel(ParallaxGroup0_PARALLAXMAP and ParallaxGroup0_USE_EXTRAMIXMAP_PARALLAX indent);False;1,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;293;-3358.781,-748.202;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;354;-3226.036,-1034.296;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;356;-3243.036,-839.2961;Inherit;False;Constant;_Float8;Float 8;72;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;355;-3075.036,-937.2961;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;297;-2502.031,-759.964;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;299;-3545.972,711.7406;Inherit;False;296;ClearCoatSmoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;279;-3476.067,53.22829;Inherit;False;271;metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;280;-3548.067,119.2283;Inherit;False;210;perceptualRoughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;281;-3513.067,190.2283;Inherit;False;208;normalTS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;282;-3508.067,264.2283;Inherit;False;270;emission;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;284;-3532.382,333.3589;Inherit;False;217;occlusionMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;285;-3511.382,388.359;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;286;-3514.382,455.359;Inherit;False;259;viewDirWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;287;-3522.382,524.3591;Inherit;False;202;alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-3521.299,-144.3357;Inherit;False;201;albedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;363;-3266.259,788.6751;Inherit;False;362;shadowCoord;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;364;-3249.259,863.6751;Inherit;False;365;positionWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;367;-3280.908,931.205;Inherit;False;366;staticLightMapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;371;-3217.908,1087.205;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;370;-3236.908,1154.205;Inherit;False;366;staticLightMapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;373;-3261.803,1219.977;Inherit;False;372;dynamicLightMapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;375;-3202.652,1293.069;Inherit;False;374;vertexSH;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-3192.908,1366.205;Inherit;False;368;mainLight;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;377;-3194.661,1471.068;Inherit;False;365;positionWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;378;-3193.661,1542.068;Inherit;False;252;positionSS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;390;-3271.567,1877.747;Inherit;False;389;isCustomReflect;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;383;-3294.959,1710.169;Inherit;False;210;perceptualRoughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;380;-3453.261,1598.767;Inherit;False;ReflectDir;-1;;7001;a73de9be7b6b71b4d92e3337acef4e55;0;2;5;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;381;-3690.261,1561.767;Inherit;False;259;viewDirWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;382;-3683.261,1642.767;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;395;-3072.985,1632.918;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;298;-3542.14,610.6072;Inherit;False;289;ClearCoatMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;399;-2552.604,360.2089;Inherit;False;brdfData;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;396;-2561.548,274.1114;Inherit;False;fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;112;-3536.463,-1155.57;Inherit;False;Property;ClearCoatGroup0;禁用/启用/清漆;59;0;Create;False;0;0;0;True;0;False;0;0;0;True;;EnumGroup;2; Off disable_ClearCoatSource_Enum, _;On, _CLEARCOAT;Create;True;False;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;250;-2334.419,2469.893;Inherit;False;EnvOcclusion;-1;;7002;1f8d06f242dc65745b935d33a763c278;5,54,1,60,1,55,1,65,1,53,1;8;3;FLOAT;0;False;5;FLOAT2;0,0;False;10;FLOAT3;0,0,0;False;21;FLOAT3;0,0,0;False;22;FLOAT;1;False;11;FLOAT3;0,0,0;False;13;FLOAT;0;False;15;FLOAT3;0,0,0;False;8;FLOAT;0;FLOAT;18;FLOAT;6;FLOAT;7;FLOAT3;33;FLOAT;36;FLOAT;24;FLOAT;29
Node;AmplifyShaderEditor.GetLocalVarNode;253;-2597.34,2371.1;Inherit;False;252;positionSS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-2613.014,2444.567;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;257;-2614.414,2519.178;Inherit;False;256;vNormalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;258;-2581.604,2589.456;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;260;-2649.45,2681.808;Inherit;False;259;viewDirWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;265;-1675.284,2659.656;Inherit;False;Property;Occlusion_On2;环境光遮蔽;11;0;Create;False;0;0;0;True;0;False;0;1;1;True;ShaderModelGroup1, _OCCLUSION;LogicalSubToggle;2;Key0;Key1;Reference;63;True;False;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;266;-1665.221,2755.656;Inherit;False;Property;Occlusion_On3;环境光遮蔽;11;0;Create;False;0;0;0;True;0;False;0;1;1;True;ShaderModelGroup1, _OCCLUSION;LogicalSubToggle;2;Key0;Key1;Reference;63;True;False;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;264;-1673.284,2560.656;Inherit;False;Property;Occlusion_On1;环境光遮蔽;11;0;Create;False;0;0;0;True;0;False;0;1;1;True;ShaderModelGroup1, _OCCLUSION;LogicalSubToggle;2;Key0;Key1;Reference;63;True;False;Fragment;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;63;-1682.081,2453.389;Inherit;False;Property;Occlusion_On;环境光遮蔽;11;0;Create;False;0;0;0;True;0;False;0;1;1;True;ShaderModelGroup1, _OCCLUSION;LogicalSubToggle;2;Key0;Key1;Create;True;False;Fragment;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;263;-1909.284,2457.655;Inherit;False;Constant;_Float3;Float 3;69;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;392;-3291.359,1969.964;Inherit;True;Property;_CustomReflectMap;自定义反射贴图;16;0;Create;False;0;0;0;True;1;LogicalLineTex(ShaderModelGroup1_customreflect indent);False;None;None;False;white;LockedToCube;Cube;-1;0;2;SAMPLERCUBE;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector4Node;393;-3332.007,2182.998;Inherit;False;Global;_CustomReflectMap_HDR;_CustomReflectMap_HDR;72;0;Fetch;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;400;-2548.604,529.2089;Inherit;False;brdfDataClearCoat;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-3245.781,-662.2021;Inherit;False;Constant;_Float7;Float 7;71;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;295;-3176.781,-574.2024;Inherit;False;Constant;_Float9;Float 7;71;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;-2630.45,2842.809;Inherit;False;201;albedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;262;-2693.45,2762.808;Inherit;False;210;perceptualRoughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;251;-2623.327,2301.434;Inherit;False;217;occlusionMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-3688.398,-876.9219;Inherit;False;Property;_ClearCoatMask;清漆遮罩;61;0;Create;False;0;0;0;True;1;LogicalSub(ClearCoatGroup0_CLEARCOAT);False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;290;-2886.781,-1014.202;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;113;-3504.399,-1058.393;Inherit;True;Property;_ClearCoatMap;清漆贴图;60;0;Create;False;0;0;0;True;1;LogicalTex(ClearCoatGroup0_CLEARCOAT, false, R_G_B_A, _);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;288;-3721.781,-1027.202;Inherit;False;310;uv_primitive;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;292;-2936.781,-759.202;Inherit;False;SubsectionLerp;-1;;7003;3b4c54dea1c34724bb8ee82b01eb8b74;0;4;9;FLOAT;0;False;12;FLOAT;0;False;13;FLOAT;1;False;14;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;296;-2302.629,-762.2563;Inherit;False;ClearCoatSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;428;-2692.986,-1028.701;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;289;-2506.781,-1019.202;Inherit;False;ClearCoatMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;-2438.27,1461.21;Inherit;False;396;fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;410;-2688.005,1601.925;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;411;-2700.005,1677.925;Inherit;False;259;viewDirWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-2706.005,1748.925;Inherit;False;368;mainLight;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;407;-2713.005,1817.925;Inherit;False;399;brdfData;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;408;-2729.005,1889.925;Inherit;False;400;brdfDataClearCoat;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;409;-2725.005,1960.925;Inherit;False;289;ClearCoatMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;419;-1411.991,2172.042;Inherit;False;270;emission;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;368;-2541.327,904.9622;Inherit;False;mainLight;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;434;-2538.219,989.0955;Inherit;False;shadowMask;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;430;-2362.889,1910.027;Inherit;False;365;positionWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;431;-2376.889,1989.027;Inherit;False;252;positionSS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;432;-2353.889,2067.027;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;433;-2318.889,2137.027;Inherit;False;259;viewDirWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;435;-2456.005,2207.726;Inherit;False;434;shadowMask;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;384;-2565.858,445.8553;Inherit;False;perceptualRoughnessClearCoat;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;385;-3346.526,1787.365;Inherit;False;384;perceptualRoughnessClearCoat;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;403;-2494.584,1533.966;Inherit;False;399;brdfData;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;404;-2452.584,1616.966;Inherit;False;400;brdfDataClearCoat;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;405;-2207.224,1629.602;Inherit;False;289;ClearCoatMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;-2315.005,2340.726;Inherit;False;289;ClearCoatMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;436;-2190.005,2197.726;Inherit;False;399;brdfData;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;437;-2294.005,2261.726;Inherit;False;400;brdfDataClearCoat;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;-2084.811,2323.919;Inherit;False;440;vertexlight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;443;-1090.644,1861.005;Inherit;False;CalculateFinalColor;-1;;7004;4a3e69251c0a99c4aac425c4fd3784d1;0;13;13;FLOAT3;0,0,0;False;14;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;10;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;18;FLOAT3;1,0,0;False;19;FLOAT;1;False;21;FLOAT;1;False;20;FLOAT;1;False;6;FLOAT3;0,0,0;False;8;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;402;-3200.153,-33.66544;Inherit;False;SurfaceData;-1;;7005;e41fa51f5f7c55c4db0e5c93e9d28133;0;13;79;FLOAT3;0,0,0;False;80;FLOAT3;1,1,1;False;84;FLOAT3;1,1,1;False;70;FLOAT;0;False;68;FLOAT;0;False;128;FLOAT3;0,0,0;False;129;FLOAT3;0,0,0;False;130;FLOAT;0;False;85;FLOAT3;0,0,0;False;86;FLOAT3;0,0,0;False;131;FLOAT;0;False;132;FLOAT;0;False;133;FLOAT;0;False;19;FLOAT3;97;FLOAT;99;FLOAT3;94;FLOAT3;95;FLOAT;90;FLOAT;89;FLOAT;101;FLOAT;0;FLOAT;87;FLOAT;103;FLOAT;88;FLOAT;91;FLOAT;92;FLOAT;93;FLOAT;96;OBJECT;121;OBJECT;106;FLOAT;143;OBJECT;140
Node;AmplifyShaderEditor.DynamicAppendNode;200;-5151.448,-732.0736;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;215;-4917.991,321.2181;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;216;-5070.123,405.0016;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-5462.596,403.89;Inherit;False;Property;_OcclusionStrength;环境光遮蔽贴图强度;12;0;Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1_OCCLUSION indent);False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;211;-4962.252,103.1551;Inherit;False;SubsectionLerp;-1;;7009;3b4c54dea1c34724bb8ee82b01eb8b74;0;4;9;FLOAT;0;False;12;FLOAT;0;False;13;FLOAT;1;False;14;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;212;-5363.677,317.026;Inherit;False;Constant;_Float1;Float 1;69;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-5481.266,153.8539;Inherit;False;Property;_Roughness;粗糙度;10;0;Create;False;0;0;0;False;1;LogicalSub(ShaderModelGroup1);False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;210;-4490.906,102.1426;Inherit;False;perceptualRoughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;-6461.522,1404.41;Inherit;False;154;_ScaleOrRotate;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;177;-6092.021,1243.138;Inherit;False;SampleSupportNoTileing_OneSample;-1;;7010;dd8b7457939c2a44e9e4de0a0843db12;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;0,0;False;5;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;178;-6092.847,1362;Inherit;False;SampleSupportNoTileing_twoSample;-1;;7011;bdfdef6c25be0344dbc4ba61cf1c3986;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;;False;5;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;179;-6102.42,1482.01;Inherit;False;SampleSupportNoTileing_HexagonSample;-1;;7012;2be24d88e4fca7d4d85f800f408556e7;0;3;2;FLOAT2;0,0;False;3;SAMPLER2D;0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;175;-6547.141,1007.951;Inherit;True;Property;_EmissionMixMap;自发光混合贴图#通用PBR:(自发光, 金属度)#场景-植物:(自发光, 次表面强度);14;0;Create;False;0;0;0;True;3;LogicalTitle(ShaderModelGroup1_SHADER_PBR, Emission Metallic);LogicalTitle(ShaderModelGroup1_SHADER_PLANT, Emission SubSurfaceWeight);LogicalTex(ShaderModelGroup1, false, RGB_A, _);False;None;None;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;66;-6125.849,1063.359;Inherit;True;Property;_EmissionMixMap02;自发光混合贴图#通用PBR:(自发光, 金属度)#场景-植物:(自发光, 次表面强度);18;0;Create;False;0;0;0;False;3;LogicalTitle(ShaderModelGroup1_SHADER_PBR, Emission Metallic);LogicalTitle(ShaderModelGroup1_SHADER_PLANT, Emission SubSurfaceWeight);LogicalTex(ShaderModelGroup1, false, RGB_A, _);False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;180;-6483.896,1237.681;Inherit;False;313;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateFragmentDataNode;232;-6650.56,1304.932;Inherit;False;0;1;positionCS;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LWGUIStaticSwitch;181;-5453.341,1196.936;Inherit;False;Property;Sample_Enum3;关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复;1;0;Create;False;0;0;0;True;0;False;0;1;1;True;;LogicalSubKeywordEnum;5;RenderStateGroup2_SurfaceOptions;_;_SAMPLE_NOISETILING;_SAMPLE_HEXAGONTILING;_SAMPLE_ONESAMPLEONTILING;Reference;47;True;True;Fragment;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;268;-4977.778,1201.041;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;273;-4820.636,1423.296;Inherit;False;SubsectionLerp;-1;;7013;3b4c54dea1c34724bb8ee82b01eb8b74;0;4;9;FLOAT;0;False;12;FLOAT;0;False;13;FLOAT;1;False;14;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-5173.986,1409.288;Inherit;False;Property;_Metallic;金属度;19;0;Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1_SHADER_PBR or ShaderModelGroup1_SHADER_ALPHATEST);False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;274;-5056.493,1481.01;Inherit;False;Constant;_Float5;Float 5;71;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;275;-5055.493,1546.01;Inherit;False;Constant;_Float6;Float 5;71;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;271;-4370.777,1425.041;Inherit;False;metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;269;-4833.778,1202.041;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;71;-4973.657,987.3732;Inherit;False;Property;_EmissionColor;自发光颜色;20;1;[HDR];Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1);False;1,1,1,1;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;283;-4739.109,1095.678;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;272;-4563.636,1180.296;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;270;-4387.777,1191.041;Inherit;False;emission;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;67;-6577.928,1718.481;Inherit;False;Property;_SubsurfaceColor;散射颜色;17;0;Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1_SHADER_PLANT);False;1,1,1,1;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;187;-5484.279,1920.042;Inherit;False;SampleSupportNoTileing_OneSample;-1;;7014;dd8b7457939c2a44e9e4de0a0843db12;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;_Sampler4187;False;5;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;188;-5485.105,2038.903;Inherit;False;SampleSupportNoTileing_twoSample;-1;;7015;bdfdef6c25be0344dbc4ba61cf1c3986;0;3;3;FLOAT2;0,0;False;4;SAMPLER2D;_Sampler4188;False;5;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;190;-5494.68,2158.912;Inherit;False;SampleSupportNoTileing_HexagonSample;-1;;7016;2be24d88e4fca7d4d85f800f408556e7;0;3;2;FLOAT2;0,0;False;3;SAMPLER2D;_Sampler3190;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;193;-5905.54,1727.04;Inherit;True;Property;_ExtraMixMap;额外混合贴图;23;0;Create;False;0;0;0;True;1;LogicalTex(ShaderModelGroup1_ExtraMixMap_Display, false, R_G_B_A, _);False;None;None;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;184;-5888.154,1941.584;Inherit;False;313;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateFragmentDataNode;233;-6070.827,1995.203;Inherit;False;0;1;positionCS;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;186;-5869.123,2127.782;Inherit;False;154;_ScaleOrRotate;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;189;-4877.114,1858.452;Inherit;False;Property;Sample_Enum4;关闭/Noise平铺/六边形平铺/抖动采样/消除纹理平铺重复;1;0;Create;False;0;0;0;True;0;False;0;1;1;True;;LogicalSubKeywordEnum;5;RenderStateGroup2_SurfaceOptions;_;_SAMPLE_NOISETILING;_SAMPLE_HEXAGONTILING;_SAMPLE_ONESAMPLEONTILING;Reference;47;True;True;Fragment;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;74;-5492.763,1730.355;Inherit;True;Property;_ExtraMixMap02;额外混合贴图;25;0;Create;False;0;0;0;False;1;LogicalTex(ShaderModelGroup1_ExtraMixMap_Display, false, R_G_B_A, _);False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LWGUIStaticSwitch;75;-5514.305,2458.905;Inherit;False;Property;WindEnabled_Enum;关闭/最快/快速/更好/最好/棕榈树/风力;24;0;Create;False;0;0;0;True;0;False;0;1;1;True;;LogicalSubKeywordEnum;7;ShaderModelGroup1_SHADER_PLANT;_WINDQUALITY_NONE;_WINDQUALITY_FASTEST;_WINDQUALITY_FAST;_WINDQUALITY_BETTER;_WINDQUALITY_BEST;_WINDQUALITY_PALM;Create;True;True;Vertex;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;387;-6154.829,436.7504;Inherit;False;Constant;_Int2;Int 2;72;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;388;-6144.829,526.7504;Inherit;False;Constant;_Int3;Int 3;72;0;Create;True;0;0;0;False;0;False;1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;61;-5955.34,478.4445;Inherit;False;Property;_CustomReflect;自定义反射;15;0;Create;False;0;0;0;True;0;False;0;0;0;True;ShaderModelGroup1, _customreflect;LogicalSubToggle;2;Key0;Key1;Create;True;False;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;389;-5588.829,530.7504;Inherit;False;isCustomReflect;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-4527.123,325.0016;Inherit;False;occlusionMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;426;-4728.755,327.7317;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;201;-4917.448,-714.0736;Inherit;False;albedo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;54;-3759.275,-25.93948;Inherit;False;Property;_SpecColor;高光颜色;6;0;Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;53;-3760.011,-203.6313;Inherit;False;Property;_BaseColor;基础颜色;5;0;Create;False;0;0;0;True;2;MainColor;LogicalSub(ShaderModelGroup1);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;65;-2913.346,2591.461;Inherit;False;Property;_HorizonOcclusion;地平线遮蔽(Horizon)强度;13;0;Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1_OCCLUSION indent);False;0;1;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-6540.928,1973.482;Inherit;False;Property;EmissionGI_GUI;自发光GI;21;0;Create;False;0;0;0;True;1;LogicalEmission(ShaderModelGroup1_SENIOR);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-6594.928,1889.481;Inherit;False;Property;_SubsurfaceIndirect;间接光散射;18;0;Create;False;0;0;0;True;1;LogicalSub(ShaderModelGroup1_SHADER_PLANT);False;0.25;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-6564.928,2056.482;Inherit;False;Property;ExtraMixMap_Display;显示额外混合贴图;22;0;Create;False;0;0;0;True;2;LogicalTitle(ShaderModelGroup1_ExtraMixMap_Display, Extra Mixed);LogicalSubToggle(ShaderModelGroup1, _ExtraMixMap_Display);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;119;-1114.993,-851.5707;Inherit;False;Property;_LogicalKeywordList;LogicalKeywordList;65;0;Create;True;0;0;0;True;1;LogicalKeywordList(_);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;446;-3008.284,834.7573;Inherit;False;MainLight;-1;;7017;8feda1e983ee2e6418994fa25e7d0c8f;0;3;29;FLOAT4;0,0,0,0;False;31;FLOAT3;0,0,0;False;30;FLOAT2;0,0;False;7;FLOAT3;0;FLOAT3;10;FLOAT;11;FLOAT;12;INT;13;OBJECT;17;FLOAT4;32
Node;AmplifyShaderEditor.FunctionNode;447;-2897.324,1129.267;Inherit;False;EnvLighting;-1;;7018;1c7b249abd298d448b85814cac86e2ab;0;5;17;FLOAT3;0,0,0;False;35;FLOAT2;0,0;False;36;FLOAT2;0,0;False;37;FLOAT3;0,0,0;False;21;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;448;-2929.022,1331.934;Inherit;False;EnvReflect;-1;;7019;5ceebe00e6af51a45836843f20fb949d;2,45,0,44,0;7;16;FLOAT3;0,0,0;False;18;FLOAT2;0,0;False;15;FLOAT3;0,0,0;False;17;FLOAT;0;False;38;FLOAT;0;False;20;SAMPLERCUBE;0;False;25;FLOAT4;0,0,0,0;False;2;FLOAT3;14;FLOAT3;43
Node;AmplifyShaderEditor.FunctionNode;358;-2413.804,1709.818;Inherit;False;UnityStandardPBRLighting_MainLight;-1;;7020;b41580952992c61469d041596eb13ef8;0;6;12;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;14;OBJECT;;False;15;OBJECT;;False;16;OBJECT;;False;17;FLOAT;0;False;2;FLOAT3;0;FLOAT3;18
Node;AmplifyShaderEditor.FunctionNode;439;-1930.076,1331.545;Inherit;False;UnityStandardPBRLighting_Indirect;-1;;7031;4e256c588e7d3354f8b27082ef19ebfc;0;7;29;FLOAT3;0,0,0;False;23;FLOAT3;0,0,0;False;42;FLOAT3;0,0,0;False;20;FLOAT;0;False;31;OBJECT;;False;43;OBJECT;;False;44;FLOAT;0;False;2;FLOAT3;28;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;449;-1838.711,1996.474;Inherit;False;UnityStandardPBRLighting_AddLight;-1;;7033;82d97dd707e557a49be2444a391eab2e;0;9;9;FLOAT3;0,0,0;False;10;FLOAT2;0,0;False;11;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;14;FLOAT4;1,1,1,1;False;15;OBJECT;;False;16;OBJECT;;False;17;FLOAT;0;False;21;FLOAT3;0,0,0;False;3;FLOAT3;0;FLOAT3;8;FLOAT3;23
Node;AmplifyShaderEditor.StickyNoteNode;450;-6036.01,3024.484;Inherit;False;968.9526;777.198;keyword;关键字;1,1,1,1;//主灯光全局关键字$multi_compile _ LIGHTMAP_SHADOW_MIXING$$multi_compile _ SHADOWS_SHADOWMASK$$multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN$$multi_compile_fragment _ _LIGHT_COOKIES $$multi_compile _ _LIGHT_LAYERS$$multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH$$//------------------------------------------------------------------------------------------------------$烘焙GI全局关键字$REQUIRE_BAKEDGI$$multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX$$multi_compile _ DIRLIGHTMAP_COMBINED$$multi_compile _ LIGHTMAP_ON$$multi_compile _ DYNAMICLIGHTMAP_ON$$//------------------------------------------------------------------------------------------------------$烘焙反射全局关键字$multi_compile_fragment _ _REFLECTION_PROBE_BLENDING$$multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION$$//------------------------------------------------------------------------------------------------------$附加灯光全局关键字$multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS$$multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS$$$;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;421;344.7299,-677.9481;Inherit;False;202;alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;370.498,-582.0979;Inherit;False;224;normalWS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;316;-585.9758,-530.5;Inherit;False;Model_EX03;-1;;7034;2d356a5891cdd85438c8a063599c590b;7,431,0,430,0,511,0,512,0,514,0,513,0,505,0;4;307;FLOAT3;0,0,0;False;432;FLOAT3;0,0,0;False;377;FLOAT3;0,0,0;False;433;FLOAT3;0,0,0;False;38;FLOAT2;371;FLOAT2;373;FLOAT3;374;FLOAT;379;FLOAT3;397;FLOAT4;347;FLOAT4;313;FLOAT4;413;FLOAT4;415;FLOAT2;273;FLOAT2;275;FLOAT3;277;FLOAT;410;FLOAT3;285;FLOAT4;243;FLOAT4;178;FLOAT3;0;FLOAT3;4;FLOAT3;5;FLOAT3x3;6;FLOAT3;312;FLOAT3;156;FLOAT3;271;FLOAT3;229;FLOAT3;7;FLOAT3;185;FLOAT3;194;FLOAT3;197;FLOAT3;11;COLOR;21;FLOAT;22;INT;202;FLOAT4;224;FLOAT4;225;FLOAT3;220;INT;216;INT;217;INT;219
Node;AmplifyShaderEditor.TemplateMultiPassSwitchNode;27;986.2557,-161.2963;Inherit;False;0;0;8;8;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;366;1030.902,60.08334;Inherit;False;staticLightMapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;372;1047.459,116.1472;Inherit;False;dynamicLightMapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;374;1044.551,174.985;Inherit;False;vertexSH;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;440;1046.149,239.1616;Inherit;False;vertexlight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;362;1066.648,399.3656;Inherit;False;shadowCoord;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;149;1056.332,469.9188;Inherit;False;positionDS;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;256;1060.075,550.2671;Inherit;False;vNormalWS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;1065.501,713.7222;Inherit;False;viewDirWS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;365;1048.06,316.2497;Inherit;False;positionWS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;252;1070.177,867.9128;Inherit;False;positionSS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;76;-9949.406,-1159.941;Inherit;False;Property;HoudiniVATGroup0;禁用/软体动画/Houdini顶点动画贴图(VAT);25;0;Create;False;0;0;0;True;0;False;0;0;0;True;;EnumGroup;2; Off, _;HoudiniVATSoft, _HOUDINI_VAT_SOFT;Create;True;True;Vertex;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LWGUIStaticSwitch;51;-6561.165,-1122.849;Inherit;False;Property;ShaderModelGroup1;通用PBR/场景-植物/着色器模型;3;0;Create;False;0;0;0;True;0;False;0;0;0;True;;EnumGroup;2;PBR_senior disable_WindEnabled_Enum, _SHADER_PBR;PLANT_senior disable_DetailGroup0 disable_ClearCoatGroup disable_ParallaxGroup0, _SHADER_PLANT;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;452;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;ExtraPrePass;0;0;ExtraPrePass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;454;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;455;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;456;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;457;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;SceneSelectionPass;0;5;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;458;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;ScenePickingPass;0;6;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;459;674,-634;Float;False;False;-1;2;LWGUI.LWGUI;0;1;New Amplify Shader;fa16f3565aea0f0448ed74c1d4f5407b;True;DepthNormals;0;7;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;453;1327.362,-393.7533;Float;False;True;-1;2;LogicalSGUI.LogicalSGUI;0;14;EXLit;fa16f3565aea0f0448ed74c1d4f5407b;True;Forward;0;1;Forward;12;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;19;Surface;0;0;  Blend;0;0;Forward Only;0;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;0;638559646760119401;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;0;8;False;True;True;True;False;True;True;True;False;;False;0
WireConnection;228;0;56;0
WireConnection;243;0;228;0
WireConnection;240;0;239;0
WireConnection;240;1;243;0
WireConnection;241;0;240;0
WireConnection;241;1;243;1
WireConnection;242;0;241;0
WireConnection;236;0;242;1
WireConnection;237;0;242;0
WireConnection;238;0;237;0
WireConnection;238;1;236;0
WireConnection;310;0;238;0
WireConnection;154;0;50;0
WireConnection;94;0;325;0
WireConnection;94;1;304;0
WireConnection;94;7;325;1
WireConnection;328;2;304;0
WireConnection;328;3;325;0
WireConnection;328;4;331;0
WireConnection;327;3;304;0
WireConnection;327;4;325;0
WireConnection;327;5;331;0
WireConnection;326;3;304;0
WireConnection;326;4;325;0
WireConnection;326;5;330;0
WireConnection;423;0;94;1
WireConnection;423;1;94;2
WireConnection;423;2;94;3
WireConnection;423;3;94;4
WireConnection;333;0;326;0
WireConnection;334;0;327;0
WireConnection;335;0;328;0
WireConnection;424;0;423;0
WireConnection;332;0;424;0
WireConnection;332;2;334;0
WireConnection;332;3;335;0
WireConnection;332;4;333;0
WireConnection;308;0;332;0
WireConnection;311;0;478;271
WireConnection;353;2;348;0
WireConnection;353;3;304;0
WireConnection;353;8;312;0
WireConnection;353;10;96;0
WireConnection;92;1;304;0
WireConnection;92;0;353;0
WireConnection;313;0;92;0
WireConnection;55;0;168;0
WireConnection;55;1;315;0
WireConnection;55;7;168;1
WireConnection;161;3;315;0
WireConnection;161;4;168;0
WireConnection;161;5;234;0
WireConnection;162;3;315;0
WireConnection;162;4;168;0
WireConnection;162;5;167;0
WireConnection;163;2;315;0
WireConnection;163;3;168;0
WireConnection;163;4;167;0
WireConnection;164;0;55;0
WireConnection;164;2;162;0
WireConnection;164;3;163;0
WireConnection;164;4;161;0
WireConnection;205;0;164;0
WireConnection;206;0;205;0
WireConnection;206;1;205;1
WireConnection;209;0;59;0
WireConnection;209;1;213;0
WireConnection;220;0;478;6
WireConnection;207;2;206;0
WireConnection;207;3;209;0
WireConnection;208;0;207;0
WireConnection;318;0;208;0
WireConnection;318;1;319;0
WireConnection;317;0;478;22
WireConnection;320;0;318;0
WireConnection;140;3;314;0
WireConnection;140;4;56;0
WireConnection;140;5;231;0
WireConnection;153;3;314;0
WireConnection;153;4;56;0
WireConnection;153;5;155;0
WireConnection;156;2;314;0
WireConnection;156;3;56;0
WireConnection;156;4;155;0
WireConnection;52;0;56;0
WireConnection;52;1;314;0
WireConnection;52;7;56;1
WireConnection;249;0;320;0
WireConnection;127;0;52;0
WireConnection;127;2;153;0
WireConnection;127;3;156;0
WireConnection;127;4;140;0
WireConnection;248;7;322;0
WireConnection;248;3;320;0
WireConnection;248;4;249;0
WireConnection;198;0;127;0
WireConnection;58;1;320;0
WireConnection;58;0;248;0
WireConnection;202;0;198;3
WireConnection;224;0;58;0
WireConnection;291;0;115;0
WireConnection;293;0;116;0
WireConnection;354;0;113;1
WireConnection;354;1;113;2
WireConnection;354;2;113;3
WireConnection;355;0;354;0
WireConnection;355;1;356;0
WireConnection;297;0;292;0
WireConnection;380;5;381;0
WireConnection;380;8;382;0
WireConnection;395;0;380;0
WireConnection;399;0;402;106
WireConnection;396;0;402;96
WireConnection;250;3;251;0
WireConnection;250;5;253;0
WireConnection;250;10;254;0
WireConnection;250;21;257;0
WireConnection;250;22;258;0
WireConnection;250;11;260;0
WireConnection;250;13;262;0
WireConnection;250;15;261;0
WireConnection;258;0;65;0
WireConnection;265;1;263;0
WireConnection;265;0;250;24
WireConnection;266;1;263;0
WireConnection;266;0;250;29
WireConnection;264;1;263;0
WireConnection;264;0;250;36
WireConnection;63;1;263;0
WireConnection;63;0;250;33
WireConnection;400;0;402;140
WireConnection;290;0;113;4
WireConnection;290;1;291;0
WireConnection;113;1;288;0
WireConnection;292;9;293;0
WireConnection;292;12;355;0
WireConnection;292;13;294;0
WireConnection;292;14;295;0
WireConnection;296;0;297;0
WireConnection;428;0;290;0
WireConnection;289;0;428;0
WireConnection;368;0;446;17
WireConnection;434;0;446;32
WireConnection;384;0;402;143
WireConnection;443;13;439;28
WireConnection;443;14;439;0
WireConnection;443;12;358;0
WireConnection;443;11;358;18
WireConnection;443;9;449;0
WireConnection;443;10;449;8
WireConnection;443;5;449;23
WireConnection;443;18;63;0
WireConnection;443;19;264;0
WireConnection;443;21;265;0
WireConnection;443;20;266;0
WireConnection;443;6;419;0
WireConnection;402;79;278;0
WireConnection;402;80;53;0
WireConnection;402;84;54;0
WireConnection;402;70;279;0
WireConnection;402;68;280;0
WireConnection;402;128;281;0
WireConnection;402;129;282;0
WireConnection;402;130;284;0
WireConnection;402;85;285;0
WireConnection;402;86;286;0
WireConnection;402;131;287;0
WireConnection;402;132;298;0
WireConnection;402;133;299;0
WireConnection;200;0;198;0
WireConnection;200;1;198;1
WireConnection;200;2;198;2
WireConnection;215;0;213;0
WireConnection;215;1;205;3
WireConnection;215;2;216;0
WireConnection;216;0;64;0
WireConnection;216;1;213;0
WireConnection;211;9;60;0
WireConnection;211;12;205;2
WireConnection;211;13;213;0
WireConnection;211;14;212;0
WireConnection;210;0;211;0
WireConnection;177;3;180;0
WireConnection;177;4;175;0
WireConnection;177;5;232;0
WireConnection;178;3;180;0
WireConnection;178;4;175;0
WireConnection;178;5;183;0
WireConnection;179;2;180;0
WireConnection;179;3;175;0
WireConnection;179;4;183;0
WireConnection;66;0;175;0
WireConnection;66;1;180;0
WireConnection;66;7;175;1
WireConnection;181;0;66;0
WireConnection;181;2;178;0
WireConnection;181;3;179;0
WireConnection;181;4;177;0
WireConnection;268;0;181;0
WireConnection;273;9;70;0
WireConnection;273;12;268;3
WireConnection;273;13;274;0
WireConnection;273;14;275;0
WireConnection;271;0;273;0
WireConnection;269;0;268;0
WireConnection;269;1;268;1
WireConnection;269;2;268;2
WireConnection;283;0;71;0
WireConnection;272;0;283;0
WireConnection;272;1;269;0
WireConnection;270;0;272;0
WireConnection;187;3;184;0
WireConnection;187;4;193;0
WireConnection;187;5;233;0
WireConnection;188;3;184;0
WireConnection;188;4;193;0
WireConnection;188;5;186;0
WireConnection;190;2;184;0
WireConnection;190;3;193;0
WireConnection;190;4;186;0
WireConnection;189;0;74;0
WireConnection;189;2;188;0
WireConnection;189;3;190;0
WireConnection;189;4;187;0
WireConnection;74;0;193;0
WireConnection;74;1;184;0
WireConnection;74;7;193;1
WireConnection;61;1;387;0
WireConnection;61;0;388;0
WireConnection;389;0;61;0
WireConnection;217;0;426;0
WireConnection;426;0;215;0
WireConnection;201;0;200;0
WireConnection;446;29;363;0
WireConnection;446;31;364;0
WireConnection;446;30;367;0
WireConnection;447;17;371;0
WireConnection;447;35;370;0
WireConnection;447;36;373;0
WireConnection;447;37;375;0
WireConnection;447;21;369;0
WireConnection;448;16;377;0
WireConnection;448;18;378;0
WireConnection;448;15;395;0
WireConnection;448;17;383;0
WireConnection;448;38;385;0
WireConnection;358;12;410;0
WireConnection;358;13;411;0
WireConnection;358;14;406;0
WireConnection;358;15;407;0
WireConnection;358;16;408;0
WireConnection;358;17;409;0
WireConnection;439;29;447;0
WireConnection;439;23;448;14
WireConnection;439;42;448;43
WireConnection;439;20;397;0
WireConnection;439;31;403;0
WireConnection;439;43;404;0
WireConnection;439;44;405;0
WireConnection;449;9;430;0
WireConnection;449;10;431;0
WireConnection;449;11;432;0
WireConnection;449;13;433;0
WireConnection;449;14;435;0
WireConnection;449;15;436;0
WireConnection;449;16;437;0
WireConnection;449;17;438;0
WireConnection;449;21;441;0
WireConnection;27;0;478;313
WireConnection;27;1;478;313
WireConnection;27;2;478;413
WireConnection;27;3;478;313
WireConnection;27;4;478;415
WireConnection;27;5;478;313
WireConnection;27;6;478;313
WireConnection;27;7;478;313
WireConnection;366;0;478;273
WireConnection;372;0;478;275
WireConnection;374;0;478;277
WireConnection;440;0;478;285
WireConnection;362;0;478;243
WireConnection;149;0;478;178
WireConnection;256;0;478;0
WireConnection;259;0;478;156
WireConnection;365;0;478;312
WireConnection;252;0;478;7
WireConnection;453;1;421;0
WireConnection;453;4;255;0
WireConnection;453;7;478;543
WireConnection;453;8;478;546
WireConnection;453;9;478;547
WireConnection;453;12;478;347
WireConnection;453;13;27;0
ASEEND*/
//CHKSM=875D932684808CDADBCFBEDBD5911F96BB1C8F67