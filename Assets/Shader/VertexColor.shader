Shader "Custom/VertexColor"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RTex ("R Tex", 2D) = "white" {}    
        _GTex ("G Tex", 2D) = "white" {} 
        _BTex ("B Tex", 2D) = "white" {} 
        _BumpMap("Normal", 2D) = "bump" {}
        _NP("Normal Power", float) = 1
        _SM("Smoothness", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _RTex;
        sampler2D _GTex;
        sampler2D _BTex;
        
        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Rtex;
            float2 uv_Gtex;
            float2 uv_Btex;

            float2 uv_BumpMap;

            float4 color:COLOR;
        };

        float _NP;
        float _SM;


        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 Rt = tex2D (_RTex, IN.uv_Rtex);
            fixed4 Gt = tex2D (_GTex, IN.uv_Gtex);
            fixed4 Bt = tex2D (_BTex, IN.uv_Btex);

            float4 Normaltex = tex2D(_BumpMap, IN.uv_BumpMap);

            o.Emission = lerp(c, Rt, IN.color.r);
            o.Emission = lerp(o.Emission, Gt, IN.color.g);
            o.Emission = lerp(o.Emission, Bt, IN.color.b);
            
            float3 Nor = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            Nor = float3(Nor.r * _NP, Nor.g * _NP, Nor.b * _NP);
            o.Normal = Nor;
            o.Smoothness = _SM;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
