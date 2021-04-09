#include "Main.h"
#include "0_01_12g.h"

extern sTask SCH_tasks_G[SCH_MAX_TASKS];
extern tByte Error_code_G;

// ------ Private function prototypes ------------------------------

static void SCH_Manual_Timer0_Reload(void);

void SCH_Init_T0(void) 
   {
   tByte i;

   for (i = 0; i < SCH_MAX_TASKS; i++) 
      {
      SCH_Delete_Task(i);
      }

   // Reset the global error variable
   // - SCH_Delete_Task() will generate an error code, 
   //   (because the task array is empty)
   Error_code_G = 0;

   // Using Timer 0, 16-bit manual reload
   TMOD &= 0xF0; // Clear all T0 bits (T1 left unchanged)
   TMOD |= 0x01; // Set required T0 bits (T1 left unchanged) 

   // Sets up timer reload values
   SCH_Manual_Timer0_Reload();

   //  Interrupt Timer 0 enabled
   ET0  = 1;
   }

/*------------------------------------------------------------------*-

  SCH_Start()

  Starts the scheduler, by enabling interrupts.

  NOTE: Usually called after all regular tasks are added,
  to keep the tasks synchronised.

  NOTE: ONLY THE SCHEDULER INTERRUPT SHOULD BE ENABLED!!! 
 
-*------------------------------------------------------------------*/
void SCH_Start(void) 
   {
   EA = 1;
   }

/*------------------------------------------------------------------*-

  SCH_Update

  This is the scheduler ISR.  It is called at a rate 
  determined by the timer settings in SCH_Init_T0().
  This version is triggered by Timer 0 interrupts.
 
-*------------------------------------------------------------------*/
void SCH_Update(void) interrupt INTERRUPT_Timer_0_Overflow 
   {
   tByte Index;

   // Reload the timer
   SCH_Manual_Timer0_Reload();

   // NOTE: calculations are in *TICKS* (not milliseconds)
   for (Index = 0; Index < SCH_MAX_TASKS; Index++)
      {
      // Check if there is a task at this location
      if (SCH_tasks_G[Index].pTask)
         {
         if (SCH_tasks_G[Index].Delay == 0)
            {
            // The task is due to run
            SCH_tasks_G[Index].RunMe += 1;  // Inc. the 'Run Me' flag

            if (SCH_tasks_G[Index].Period)
               {
               // Schedule periodic tasks to run again
               SCH_tasks_G[Index].Delay = SCH_tasks_G[Index].Period;
               }
            }
         else
            {
            // Not yet ready to run: just decrement the delay 
            SCH_tasks_G[Index].Delay -= 1;
            }
         }         
      }
   } 

/*------------------------------------------------------------------*-
-*------------------------------------------------------------------*/
void SCH_Manual_Timer0_Reload()
   {
   // Stop Timer 0
   TR0 = 0;

   // 8051, 12 MHz
   // The Timer 0 resolution is 1.000 µs
   // We set the timer at 64336 to generate interrupt after 1 ms
   // -> we are generating timer ticks at ~1 ms intervals
   TL0  = 0x18;
   TH0  = 0xFC;

   //  Start Timer 0
   TR0  = 1;
   }

/*------------------------------------------------------------------*-
  ---- END OF FILE -------------------------------------------------
-*------------------------------------------------------------------*/

