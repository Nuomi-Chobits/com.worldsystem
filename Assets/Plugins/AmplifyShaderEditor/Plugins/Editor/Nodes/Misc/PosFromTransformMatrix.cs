


using System;
namespace AmplifyShaderEditor
{
	[Serializable]
	[NodeAttributes( 
#if !WB_LANGUAGE_CHINESE
"Position From Transform"
#else
"位置转换"
#endif
,            /*<!C>*/
#if !WB_LANGUAGE_CHINESE
"Matrix Operators"
#else
"矩阵运算符"
#endif
/*<C!>*/, 
#if !WB_LANGUAGE_CHINESE
"Gets the position vector from a transformation matrix"
#else
"从变换矩阵中获取位置向量"
#endif
)]
	public sealed class PosFromTransformMatrix : ParentNode
	{
		protected override void CommonInit( int uniqueId )
		{
			base.CommonInit( uniqueId );
			AddInputPort( WirePortDataType.FLOAT4x4, true, Constants.EmptyPortValue );
			AddOutputPort( WirePortDataType.FLOAT4, "XYZW" );
			AddOutputPort( WirePortDataType.FLOAT, "X" );
			AddOutputPort( WirePortDataType.FLOAT, "Y" );
			AddOutputPort( WirePortDataType.FLOAT, "Z" );
			AddOutputPort( WirePortDataType.FLOAT, "W" );
		}

		public override string GenerateShaderForOutput( int outputId, ref MasterNodeDataCollector dataCollector, bool ignoreLocalvar )
		{
			if( m_outputPorts[ 0 ].IsLocalValue( dataCollector.PortCategory ) )
				return GetOutputVectorItem( 0, outputId, m_outputPorts[ 0 ].LocalValue( dataCollector.PortCategory ) );

			string value = m_inputPorts[ 0 ].GeneratePortInstructions( ref dataCollector  );
			string result = string.Format( "float4( {0},{1},{2},{3})", value + "[0][3]", value + "[1][3]", value + "[2][3]", value + "[3][3]" );
			RegisterLocalVariable( 0, result, ref dataCollector, "matrixToPos" + OutputId );

			return GetOutputVectorItem( 0, outputId, m_outputPorts[ 0 ].LocalValue( dataCollector.PortCategory ) );
		}
	}
}
