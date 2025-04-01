Shader "Custom/Custom_Light"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _NormalMap ("NormalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf CustomLight noambient

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
        };

        fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Normal = UnpackNormal(tex2D (_NormalMap, IN.uv_NormalMap));
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        float4 LightingCustomLight(SurfaceOutput s, float3 lightDIr, float atten)
        {
            float nDotL = saturate(dot(s.Normal, lightDIr));
            return nDotL;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
