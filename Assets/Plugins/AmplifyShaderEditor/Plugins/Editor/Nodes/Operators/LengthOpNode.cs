


namespace AmplifyShaderEditor
{
	[System.Serializable]
	[NodeAttributes( 
#if !WB_LANGUAGE_CHINESE
"Length"
#else
"长度"
#endif
,            /*<!C>*/
#if !WB_LANGUAGE_CHINESE
"Vector Operators"
#else
"矢量运算符"
#endif
/*<C!>*/, 
#if !WB_LANGUAGE_CHINESE
"Scalar Euclidean length of a vector"
#else
"向量的标量欧几里德长度"
#endif
)]
	public sealed class LengthOpNode : SingleInputOp
	{
		protected override void CommonInit( int uniqueId )
		{
			base.CommonInit( uniqueId );
			m_opName = "length";
			m_previewShaderGUID = "1c1f6d6512b758942a8b9dd1bea12f34";
			m_inputPorts[ 0 ].CreatePortRestrictions(	WirePortDataType.OBJECT,
														WirePortDataType.FLOAT ,
														WirePortDataType.FLOAT2,
														WirePortDataType.FLOAT3,
														WirePortDataType.FLOAT4,
														WirePortDataType.COLOR ,
														WirePortDataType.INT);
			m_inputPorts[ 0 ].ChangeType( WirePortDataType.FLOAT4, false );
			m_autoUpdateOutputPort = false;
		}
		public override void SetPreviewInputs()
		{
			base.SetPreviewInputs();
			switch( m_inputPorts[0].DataType )
			{
				case WirePortDataType.OBJECT:
				case WirePortDataType.INT:
				case WirePortDataType.FLOAT:
				case WirePortDataType.UINT:m_previewMaterialPassId = 0;break;
				case WirePortDataType.FLOAT2:m_previewMaterialPassId = 1;break;
				case WirePortDataType.FLOAT3:m_previewMaterialPassId = 2;break;
				case WirePortDataType.FLOAT4:
				case WirePortDataType.COLOR:m_previewMaterialPassId = 3;break;	
			}
		}
	}
}
