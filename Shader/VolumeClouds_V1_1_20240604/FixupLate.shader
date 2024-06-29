Shader "Unlit/FixupLate"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline"}
        ZWrite Off
        Cull Off
        ZTest Always
        
        Pass
        {
            Name "Reproject"
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Fragment

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.core/Runtime/Utilities/Blit.hlsl"
            
            float4x4 _InverseViewProjM_PerFrame;
            float4x4 _PrevViewProjM_PerFrame;
            float4x4 _ViewProjM_PerFrame;
            float2 GetMotionVector_Modif(float2 uv)
            {
                
            #if UNITY_REVERSED_Z
                float depth = 0;
            #else
                float depth = 1.0;
            #endif
                
                //float4 worldPos = float4(ComputeWorldSpacePosition(uv, depth, UNITY_MATRIX_I_VP), 1.0);
                float4 worldPos = float4(ComputeWorldSpacePosition(uv, depth, _InverseViewProjM_PerFrame), 1.0);

                float4 prevClipPos = mul(_PrevViewProjM_PerFrame, worldPos);
                float4 curClipPos = mul(_ViewProjM_PerFrame, worldPos);

                float2 prevPosCS = prevClipPos.xy / prevClipPos.w;
                float2 curPosCS = curClipPos.xy / curClipPos.w;
                
                float2 velocity = (prevPosCS - curPosCS);
                
            #if UNITY_UV_STARTS_AT_TOP
                    velocity.y = -velocity.y;
            #endif

                return velocity * 0.5;
            }
            bool IsUVInRange01(float2 UV)
            {
	            if (UV.x <= 0.0 || UV.x >= 1.0 || UV.y <= 0.0 || UV.y >= 1.0)
	            {
		            return false;
	            }
	            return true;
            }

            
            float _FOVScale;
            
            TEXTURE2D(_ActiveTarget);SAMPLER(sampler_ActiveTarget);

            float4 Fragment(Varyings input) : SV_Target
            {
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
                float2 UV = input.texcoord;
                float2 motionVectors = GetMotionVector_Modif(input.texcoord);
                float2 HistUV = UV + motionVectors;
                
                return SAMPLE_TEXTURE2D(_ActiveTarget,sampler_ActiveTarget,HistUV);
                // bool isValidHistUV = IsUVInRange01(HistUV);
                // if(isValidHistUV)
                // {
                //     return SAMPLE_TEXTURE2D(_ActiveTarget,sampler_ActiveTarget,HistUV);
                // }
                // else
                // {
                //     return half4(1,0,0,1);
                // }
                
            }
            ENDHLSL
        }
    }
}
