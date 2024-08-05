classdef Test_m2json < matlab.unittest.TestCase
    methods (Test)
        function testInRange0to10(tc)
            values = 1 + (1:5) + 0.23456789;
            expected = "[2.235,3.235,4.235,5.235,6.235]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function test2dArrayInRange0to10(tc)
            values = 1 + (1:5) + (0:1)' + 0.23456789;
            expected = "[[2.235,3.235,4.235,5.235,6.235]," ...
                    + "[3.235,4.235,5.235,6.235,7.235]]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testInRange1e6to1e5(tc)
            values = 1e-6 * (1 + (1:5) + 0.23456789);
            expected = "[2.235e-06,3.235e-06,4.235e-06,5.235e-06," ...
                    + "6.235e-06]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testInRange1e14Plus0to1(tc)
            values = 1e14 + (1:5) + 0.23456789;
            expected = "[100000000000001,100000000000002,"...
                    + "100000000000003,100000000000004,100000000000005]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testInRange1e14Plus1e7Plus0to1(tc)
            values = 1e14 + 1e7 + (1:5) + 0.23456789;
            expected = "[100000010000001,100000010000002," ...
                    + "100000010000003,100000010000004,100000010000005]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testLogScaledVariables(tc)
            values = 1e14 + 10.^(1:5) + 0.23456789;
            expected = "[1e+14,1.000000000001e+14,1.00000000001e+14," ...
                    + "1.0000000001e+14,1.000000001e+14]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testInRangeMinus10to0(tc)
            values = -(1 + (1:5) + 0.23456789);
            expected = "[-2.235,-3.235,-4.235,-5.235,-6.235]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testInRangeMinus1e5toMinus1e6(tc)
            values = -1e-6 * (1 + (1:5) + 0.23456789);
            expected = "[-2.235e-06,-3.235e-06,-4.235e-06,-5.235e-06," ...
                    + "-6.235e-06]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testInRangeMinus1e14Plus0to1(tc)
            values = -1e14 + (1:5) + 0.23456789;
            expected = "[-99999999999998.8,-99999999999997.8," ...
                    + "-99999999999996.8,-99999999999995.8," ...
                    + "-99999999999994.8]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testCell(tc)
            values = {1, "text", [1,2,3]};
            expected = "[1, ""text"", [1,2,3]]";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testStruct(tc)
            values = struct("a", 1, "b", "text");
            expected = "{""a"" : 1, ""b"" : ""text""}";
            tc.verifyEqual(string(m2json(values)), expected);
        end

        function testDatetime(tc)
            value = datetime("2023-05-01 12:30:45");
            expected = """2023-05-01 12:30:45""";
            tc.verifyEqual(string(m2json(value)), expected);
        end

        function testDate(tc)
            value = datetime("2023-05-01");
            expected = """2023-05-01""";
            tc.verifyEqual(string(m2json(value)), expected);
        end

        function testLogicalTrue(tc)
            value = true;
            expected = "true";
            tc.verifyEqual(string(m2json(value)), expected);
        end

        function testLogicalFalse(tc)
            value = false;
            expected = "false";
            tc.verifyEqual(string(m2json(value)), expected);
        end

        function testCharArray(tc)
            value = 'Hello';
            expected = """Hello""";
            tc.verifyEqual(string(m2json(value)), expected);
        end

        function testString(tc)
            value = "World";
            expected = """World""";
            tc.verifyEqual(string(m2json(value)), expected);
        end
    end
end
