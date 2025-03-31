Shader "Custom/Vertex Color"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "white" {}
        _MainTex3("Albedo (RGB)", 2D) = "white" {}
        _MainTex4("Albedo (RGB)", 2D) = "white" {}

        _Smooth("Smoothness", Range(0, 1)) = 0.5
        _Metallic("Metallic", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        sampler2D _MainTex3;
        sampler2D _MainTex4;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
            float2 uv_MainTex3;
            float2 uv_MainTex4;
            float4 color:COLOR;
        };

        half _Smooth;
        half _Metallic;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_MainTex2, IN.uv_MainTex2);
            fixed4 e = tex2D(_MainTex3, IN.uv_MainTex3);
            fixed4 f = tex2D(_MainTex4, IN.uv_MainTex4);

            // o.Albedo = lerp(c.rgb, d.rgb, IN.color.r);
            // o.Albedo = lerp(o.Albedo, e.rgb, IN.color.g);
            // o.Albedo = lerp(o.Albedo, f.rgb, IN.color.b);
            // o.Alpha = c.a;

            o.Emission = lerp(c, d, IN.color.r);
            o.Emission = lerp(o.Emission, e, IN.color.g);
            o.Emission = lerp(o.Emission, f, IN.color.b);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
