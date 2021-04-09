

// ------ Sch51.C ----------------------------------------

// Comment this line out if error reporting is NOT required
#define SCH_REPORT_ERRORS

#ifdef SCH_REPORT_ERRORS
// The port on which error codes will be displayed
// ONLY USED IF ERRORS ARE REPORTED
#define Error_port P2

#endif

// ------ LED_Flas.C -----------------------------------------------

// Connect LED from +5V (etc) to this pin, via appropriate resistor
// [see Chapter 7 for details]
sbit LED_pin = P0^0; 


/*------------------------------------------------------------------*-
  ---- END OF FILE -------------------------------------------------
-*------------------------------------------------------------------*/



